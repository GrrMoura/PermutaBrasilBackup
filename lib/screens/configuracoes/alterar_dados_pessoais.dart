import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/utils/app_colors.dart';
import 'package:permutabrasil/utils/app_dimens.dart';
import 'package:permutabrasil/utils/mask_utils.dart';
import 'package:permutabrasil/utils/styles.dart';
import 'package:permutabrasil/utils/validator.dart';
import 'package:permutabrasil/viewModel/profissional_view_model.dart';

class AlterarDadosPessoaisScreen extends ConsumerStatefulWidget {
  const AlterarDadosPessoaisScreen({super.key});

  @override
  ConsumerState<AlterarDadosPessoaisScreen> createState() =>
      _AlterarDadosPessoaisScreenState();
}

class _AlterarDadosPessoaisScreenState
    extends ConsumerState<AlterarDadosPessoaisScreen> {
  final _formKey = GlobalKey<FormState>();
  ValidationResult result = ValidationResult();
  bool _isLoading = true;
  late ProfissionalViewModel usuarioModel;

  @override
  void initState() {
    super.initState();
    final profissional = ref.read(profissionalProvider);
    if (profissional == null) {
      // Pode navegar de volta ou mostrar erro
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      usuarioModel = profissional;
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Alterar Dados', style: TextStyle(color: Colors.white)),
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
                  'Atualizar Informações',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cAccentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                _buildGenericTextField(
                  init: usuarioModel.usuario.nome ?? '',
                  label: 'Nome',
                  formato: MaskUtils.padrao(),
                  onSave: (String? value) {
                    usuarioModel.usuario.nome = value;
                  },
                  validator: (String? value) {
                    result = stringIsValid(value!);
                    if (result.isValid!) {
                      return null;
                    }
                    return result.errorMessage;
                  },
                  prefixIcon: Icons.person,
                ),
                _buildGenericTextField(
                  init: usuarioModel.patenteClasse ?? '',
                  label: 'Graduação ou Patente',
                  formato: MaskUtils.padrao(),
                  onSave: (String? value) {
                    usuarioModel.patenteClasse = value;
                  },
                  validator: (String? value) {
                    result = stringIsValid(value!);
                    if (result.isValid!) {
                      return null;
                    }
                    return result.errorMessage;
                  },
                  prefixIcon: Icons.star,
                ),
                _buildGenericTextField(
                  init: formatarTelefone(usuarioModel.telefone),
                  formato: MaskUtils.maskTelefone(),
                  label: 'Telefone',
                  onSave: (String? value) {
                    usuarioModel.telefone = value ?? "";
                  },
                  validator: (String? telefone) {
                    result = telefoneIsValid(telefone);
                    if (result.isValid!) {
                      return null;
                    }
                    return result.errorMessage;
                  },
                  keyboardType: TextInputType.datetime,
                  prefixIcon: Icons.phone,
                ),
                _buildGenericTextField(
                  init: formatarData(usuarioModel.dataNascimento) ?? '',
                  formato: MaskUtils.maskFormatterData(),
                  label: 'Data de Nascimento',
                  onSave: (String? value) {
                    usuarioModel.dataNascimento = value ?? "";
                  },
                  validator: (String? dataNascimento) {
                    result = dataInclusaoIsValid(dataNascimento);
                    if (result.isValid!) {
                      return null;
                    }
                    return result.errorMessage;
                  },
                  keyboardType: TextInputType.datetime,
                  prefixIcon: Icons.calendar_month,
                ),
                _buildGenericTextField(
                  init: formatarData(usuarioModel.dataInclusao) ?? '',
                  formato: MaskUtils.maskFormatterData(),
                  label: 'Data de Inclusão',
                  onSave: (String? value) {
                    usuarioModel.dataInclusao = value ?? "";
                  },
                  validator: (String? dataInclusao) {
                    result = dataInclusaoIsValid(dataInclusao);
                    if (result.isValid!) {
                      return null;
                    }
                    return result.errorMessage;
                  },
                  keyboardType: TextInputType.datetime,
                  prefixIcon: Icons.calendar_month,
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: Styles().elevatedButtonStyle(),
                    child: _isLoading
                        ? LoadingDualRing(tamanho: 20.sp)
                        : Text('Salvar Alterações',
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

    //await UserController.alterarDadosPessoais(context, );

    setState(() => _isLoading = false);
  }

  Widget _buildGenericTextField(
      {required String label,
      required void Function(String?) onSave,
      void Function(String?)? onChanged,
      required String? Function(String?)? validator,
      required IconData prefixIcon,
      MaskTextInputFormatter? formato,
      TextInputType keyboardType = TextInputType.text,
      bool obscureText = false,
      void Function()? funcaoObscure,
      String? init}) {
    return Padding(
      key: Key(label),
      padding: EdgeInsets.only(top: 10.h),
      child: TextFormField(
        initialValue: init,
        inputFormatters: [formato ?? MaskUtils.padrao()],
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: label.toLowerCase().contains('senha')
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: funcaoObscure,
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
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }

  String? formatarData(String? dataOriginal) {
    if (dataOriginal == null || dataOriginal.isEmpty) return null;

    try {
      DateTime data = DateTime.parse(dataOriginal);
      return DateFormat('dd-MM-yyyy').format(data);
    } catch (e) {
      return null;
    }
  }

  String formatarTelefone(String numero) {
    final apenasNumeros = numero.replaceAll(RegExp(r'\D'), '');

    if (apenasNumeros.length >= 11) {
      final ddd = apenasNumeros.substring(0, 2);
      final digito9 = apenasNumeros.substring(2, 3);
      final primeiraParte = apenasNumeros.substring(3, 7);
      final segundaParte = apenasNumeros.substring(7, 11);

      return '$ddd $digito9 $primeiraParte $segundaParte';
    }

    return numero;
  }
}
