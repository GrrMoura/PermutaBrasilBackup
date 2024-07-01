import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permuta_brasil/controller/user_controller.dart';
import 'package:permuta_brasil/models/recuperar_senha_model.dart';
import 'package:permuta_brasil/utils/app_colors.dart';

import 'package:permuta_brasil/utils/styles.dart';

class RecuperarSenhaScreen extends StatefulWidget {
  const RecuperarSenhaScreen({super.key});

  @override
  RecuperarSenhaScreenState createState() => RecuperarSenhaScreenState();
}

class RecuperarSenhaScreenState extends State<RecuperarSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  RecuperarSenhaModel recuperarSenhaModel = RecuperarSenhaModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recuperar Senha',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.cAccentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 60.h),
              Text(
                'Esqueceu sua senha?',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cAccentColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Text(
                'Por favor, insira seu email para enviar um link de recuperação de senha.',
                textAlign: TextAlign.center,
                style: Styles()
                    .mediumTextStyle()
                    .copyWith(color: AppColors.cTextLightColor),
              ),
              SizedBox(height: 40.h),
              _buildGenericTextField(
                label: 'Email',
                onSave: (String? value) {
                  recuperarSenhaModel.email = value;
                },
                validator: (String? value) {
                  return _validateEmail(value);
                },
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: Styles().elevatedButtonStyle(),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white))
                      : const Text('Enviar'),
                ),
              ),
              SizedBox(height: 40.h),
              TextButton(
                onPressed: () {
                  // Navegar de volta para a tela de login
                  // Navigator.pop(context);
                },
                child:
                    Text('Voltar ao Login', style: Styles().mediumTextStyle()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      await UserController.recuperarSenha(context, recuperarSenhaModel);

      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildGenericTextField({
    required String label,
    required void Function(String?) onSave,
    required String? Function(String?)? validator,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: keyboardType,
        onSaved: onSave,
        validator: validator,
        enabled: !_isLoading,
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o email';
    }
    // Regex pattern para validação de email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }
}
