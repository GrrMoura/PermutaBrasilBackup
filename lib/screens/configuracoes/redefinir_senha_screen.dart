import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permutabrasil/controller/user_controller.dart';
import 'package:permutabrasil/models/redefinir_senha_model.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/utils/app_colors.dart';
import 'package:permutabrasil/utils/app_dimens.dart';
import 'package:permutabrasil/utils/styles.dart';
import 'package:permutabrasil/utils/validator.dart';

class RedefinirSenhaScreen extends StatefulWidget {
  final bool modoInterno;
  final String? token;

  const RedefinirSenhaScreen(
      {super.key, required this.modoInterno, this.token});

  @override
  State<RedefinirSenhaScreen> createState() => _RedefinirSenhaScreenState();
}

class _RedefinirSenhaScreenState extends State<RedefinirSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _verSenha = false;
  bool _verConfirmacao = false;
  RedefinirSenhaModel redefinirSenhaModel = RedefinirSenhaModel();
  ValidationResult result = ValidationResult();

  @override
  void initState() {
    super.initState();
    if (!widget.modoInterno) {
      final token = GoRouterState.of(context).uri.queryParameters['token'];
      if (token != null) {
        redefinirSenhaModel.token = token;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Token inválido ou ausente.')),
          );
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redefinir Senha',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.cAccentColor,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Text(
                  'Nova Senha',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cAccentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Informe sua nova senha abaixo.',
                  textAlign: TextAlign.center,
                  style: Styles()
                      .mediumTextStyle()
                      .copyWith(color: AppColors.cTextLightColor),
                ),
                SizedBox(height: 40.h),
                _buildGenericTextField(
                  label: 'Nova Senha',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  mostrarBotaoVerSenha: true,
                  mostrarTexto: _verSenha,
                  onToggleVisibility: () {
                    setState(() => _verSenha = !_verSenha);
                  },
                  onSave: (val) => redefinirSenhaModel.novaSenha = val,
                  validator: (val) {
                    result = senhaIsValid(val!);
                    return result.isValid! ? null : result.errorMessage;
                  },
                ),
                _buildGenericTextField(
                  label: 'Confirmar Nova Senha',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  mostrarBotaoVerSenha: true,
                  mostrarTexto: _verConfirmacao,
                  onToggleVisibility: () {
                    setState(() => _verConfirmacao = !_verConfirmacao);
                  },
                  onSave: (val) => redefinirSenhaModel.confirmarSenha = val,
                  validator: (val) {
                    if (val != redefinirSenhaModel.novaSenha) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: Styles().elevatedButtonStyle(),
                    child: _isLoading
                        ? LoadingDualRing(tamanho: 20.sp)
                        : Text('Salvar Nova Senha',
                            style: TextStyle(fontSize: 13.sp)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState?.save();
    setState(() => _isLoading = true);

    if (widget.modoInterno) {
      await UserController.alterarSenhaInterna(context, redefinirSenhaModel);
    } else {
      await UserController.redefinirSenha(context, redefinirSenhaModel);
    }

    setState(() => _isLoading = false);
  }

  Widget _buildGenericTextField({
    required String label,
    required IconData prefixIcon,
    required void Function(String?) onSave,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool mostrarBotaoVerSenha = false,
    required bool mostrarTexto,
    required VoidCallback onToggleVisibility,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: TextFormField(
        obscureText: obscureText && !mostrarTexto,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: mostrarBotaoVerSenha
              ? IconButton(
                  icon: Icon(
                    mostrarTexto ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.borda20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.borda20),
            borderSide: const BorderSide(width: 2),
          ),
        ),
        keyboardType: keyboardType,
        onSaved: onSave,
        validator: validator,
        enabled: !_isLoading,
      ),
    );
  }
}
