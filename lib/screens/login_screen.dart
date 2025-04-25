import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permuta_brasil/controller/autenticacao_controller.dart';
import 'package:permuta_brasil/controller/user_controller.dart';
import 'package:permuta_brasil/models/autenticao_model.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/screens/widgets/loading_default.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/app_dimens.dart';
import 'package:permuta_brasil/utils/app_constantes.dart';
import 'package:permuta_brasil/utils/mask_utils.dart';
import 'package:permuta_brasil/utils/styles.dart';
import 'package:permuta_brasil/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AutenticacaoModel authModel = AutenticacaoModel();
  ValidationResult result = ValidationResult();
  bool _isObscured = true;
  Timer? _hidePasswordTimer;

  @override
  void dispose() {
    _hidePasswordTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20.h),
              Image.asset(
                AppName.logo,
                height: 230.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Text(
                  "Permuta Brasil",
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildGenericTextField(
                      prefixIcon: Icons.email,
                      label: "Email",
                      onSave: (String? value) {
                        authModel.login = value;
                      },
                      validator: (String? email) {
                        result = emailIsValid(email!);
                        if (result.isValid!) {
                          return null;
                        }
                        return result.errorMessage;
                      },
                    ),
                    _buildGenericTextField(
                      prefixIcon: Icons.lock,
                      label: "Senha",
                      onSave: (String? value) {
                        authModel.senha = value;
                      },
                      validator: (String? password) {
                        result = senhaIsValid(password!);
                        if (result.isValid!) {
                          return null;
                        }
                        return result.errorMessage;
                      },
                    ),
                    _buildRecoverPassword(),
                    _buildEnterButton(),
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenericTextField({
    required String label,
    required void Function(String?) onSave,
    required String? Function(String?)? validator,
    required IconData prefixIcon,
    MaskTextInputFormatter? formato,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      width: 300.w,
      child: Padding(
        key: Key(label),
        padding: EdgeInsets.only(top: 8.h),
        child: TextFormField(
          obscureText: label == "Email" ? false : _isObscured,
          inputFormatters: [formato ?? MaskUtils.padrao()],
          decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(prefixIcon),
              suffixIcon: label == "Senha"
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });

                        _startEsconderPasswordTimer();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.h1Size)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.borda20),
                borderSide: const BorderSide(width: 2),
              )),
          keyboardType: keyboardType,
          onSaved: onSave,
          validator: validator,
        ),
      ),
    );
  }

  void _startEsconderPasswordTimer() {
    _hidePasswordTimer?.cancel(); // para cancelar o timer anterior se existir
    _hidePasswordTimer = Timer(const Duration(seconds: 5), () {
      if (_isObscured == false) {
        setState(() {
          _isObscured = true;
        });
      }
    });
  }

  Widget _buildRecoverPassword() {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                context.push(AppRouterName.recuperarSenha);
              },
              child: Text(
                "Esqueceu senha?",
                style:
                    TextStyle(fontSize: 12.sp, color: AppColors.sShadowColor),
              )),
        ],
      ),
    );
  }

  Widget _buildEnterButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _validateUserAndSenhaTextfield,
            style: Styles().elevatedButtonStyle(),
            child: _isLoading
                ? LoadingDualRing(tamanho: 20.sp)
                : Text(
                    'Enviar',
                    style: TextStyle(fontSize: 13.sp),
                  ),
          ),
        ));
  }

  Widget _buildFooter() {
    return Align(
      key: const Key("cadastrar"),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          context.push(AppRouterName.cadastro);
        },
        child: Text.rich(
          TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 12.sp),
            children: const [
              TextSpan(text: 'Não possui conta ?  '),
              TextSpan(
                text: 'Cadastre-se !',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateUserAndSenhaTextfield() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      await AutenticacaoController.logar(context, authModel);

      setState(() {
        _isLoading = false;
      });
    }
  }
}
