import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permuta_brasil/controller/estado_controller.dart';
import 'package:permuta_brasil/controller/user_controller.dart';
import 'package:permuta_brasil/data/sqflite_helper.dart';
import 'package:permuta_brasil/models/estado_instituicoes_model.dart';
import 'package:permuta_brasil/models/estado_model.dart';
import 'package:permuta_brasil/models/instituicao_model.dart';
import 'package:permuta_brasil/models/usuario_model.dart';
import 'package:permuta_brasil/screens/widgets/loading_default.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/app_dimens.dart';
import 'package:permuta_brasil/utils/mask_utils.dart';
import 'package:permuta_brasil/utils/validator.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  CadastroScreenState createState() => CadastroScreenState();
}

class CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  UsuarioModel usuarioModel = UsuarioModel();
  ValidationResult result = ValidationResult();
  List<EstadoModel>? estados = [];
  List<InstituicaoModel>? instituicoes = [];
  List<String> estadosSelecionados = [];
  int _currentPage = 0;

  final ImagePicker _picker = ImagePicker();
  DatabaseHelper db = DatabaseHelper();

  int? selectedEstadoOrigemId;

  int? selectedInstituicaoId;
  int? selectedEstadoDestinoId;
  bool _obscureTextSenha = true;
  bool _obscureTextConfirmarSenha = true;

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  Future<void> _loadEstados() async {
    EstadosEInstituicoes resultado = await EstadoController.getEstados(context);

    List<EstadoModel> estadosPegos = resultado.estados;
    List<InstituicaoModel> instituicoesPegas = resultado.instituicoes;

    setState(() {
      estados = estadosPegos;
      instituicoes = instituicoesPegas;
    });
  }

  List<Widget> get _paginas => [
        _buildPagina1(),
        _buildPagina2(),
        _buildPagina3()
        // nova página
        // ...adicione quantas quiser
      ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        //   usuarioModel.identidadeFuncional = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.cAccentColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: Column(
            children: [
              if (_currentPage == 2) _buildTitulo(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: _paginas[_currentPage],
                      ),
                    ],
                  ),
                ),
              ),
              if (_currentPage == 2)
                if (estadosSelecionados.isNotEmpty) _buildSelecionados(),
              // botão fixo no rodapé
              Padding(
                padding: EdgeInsets.only(bottom: 5.h, left: 10.w, right: 10.w),
                child: NavegacaoButtons(
                  paginaLength: _paginas.length,
                  currentPage: _currentPage,
                  onNext: _proxima,
                  onPrevious: _voltar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitulo() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, top: 5.h),
      child: const Text(
        "Selecione um ou mais estados",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding _buildSelecionados() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selecionados",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: estadosSelecionados
                .map((estado) => Chip(
                      label: Text(
                        estado,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                      backgroundColor: Colors.teal,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Column _buildPagina1() {
    return Column(
      children: [
        _buildGenericTextField(
          init: usuarioModel.nome ?? '',
          label: 'Nome',
          formato: MaskUtils.padrao(),
          onSave: (String? value) {
            usuarioModel.nome = value;
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
          init: usuarioModel.cpf ?? "",
          label: 'CPF',
          formato: MaskUtils.maskFormatterCpf(),
          onSave: (String? value) {
            usuarioModel.cpf = value;
          },
          validator: (String? value) {
            result = cpfIsValid(value);
            if (result.isValid!) {
              return null;
            }
            return result.errorMessage;
          },
          keyboardType: TextInputType.number,
          prefixIcon: Icons.assignment_ind,
        ),
        _buildGenericTextField(
          label: 'Data de Nascimento',
          formato: MaskUtils.maskFormatterData(),
          onSave: (String? value) {
            usuarioModel.dataNascimento = parseDate(value!);
          },
          validator: (String? dtNascimento) {
            result = dataNascimentoIsValid(dtNascimento);
            if (result.isValid!) {
              return null;
            }
            return result.errorMessage;
          },
          keyboardType: TextInputType.datetime,
          prefixIcon: Icons.calendar_today,
        ),
        _buildGenericTextField(
          init: usuarioModel.email ?? "",
          label: 'E-mail',
          onSave: (String? value) {
            usuarioModel.email = value;
          },
          validator: (String? email) {
            result = emailIsValid(email!);
            if (result.isValid!) {
              return null;
            }
            return result.errorMessage;
          },
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email,
        ),
        _buildGenericTextField(
            init: usuarioModel.senha ?? "",
            label: 'Senha',
            onSave: (String? value) {
              usuarioModel.senha = value;
            },
            onChanged: (String? value) {
              usuarioModel.senha = value;
            },
            validator: (String? email) {
              result = senhaIsValid(email!);
              if (result.isValid!) {
                return null;
              }
              return result.errorMessage;
            },
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: Icons.lock,
            funcaoObscure: () {
              setState(() {
                _obscureTextSenha = !_obscureTextSenha;
              });
            },
            obscureText: _obscureTextSenha),
        _buildGenericTextField(
            init: usuarioModel.confirmarSenha ?? "",
            label: 'Confirmar Senha',
            onSave: (String? value) {
              usuarioModel.confirmarSenha = value;
            },
            onChanged: (String? value) {
              usuarioModel.confirmarSenha = value;
            },
            validator: (String? confirmPassword) {
              if (confirmPassword == null || confirmPassword.isEmpty) {
                return 'Confirmação de senha é obrigatória';
              }
              if (confirmPassword != usuarioModel.senha) {
                return 'As senhas não coincidem';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.lock,
            funcaoObscure: () {
              setState(() {
                _obscureTextConfirmarSenha = !_obscureTextConfirmarSenha;
              });
            },
            obscureText: _obscureTextConfirmarSenha),
        SizedBox(height: 30.h),
        // Row(
        //   children: [
        //     NavegacaoButtons(
        //       paginaLength: _paginas.length,
        //       currentPage: _currentPage,
        //       onNext: _proxima,
        //       onPrevious: _voltar,
        //     ),
        //   ],
        // )
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     onPressed: _isLoading ? null : _submitForm,
        //     style: Styles().elevatedButtonStyle(),
        //     child: _isLoading
        //         ? const CircularProgressIndicator(
        //             valueColor: AlwaysStoppedAnimation<Color>(
        //                 Colors.white))
        //         : const Text('Próximo'),
        //   ),
        // ),
      ],
    );
  }

  Column _buildPagina2() {
    return Column(
      children: [
        _buildDropdownField(
          icon: Icons.work,
          lista: instituicoes,
          model: instituicoes,
          label: 'Instituição',
          value: selectedInstituicaoId ?? 1,
          onChanged: (value) {
            setState(() {
              selectedInstituicaoId = value;
              usuarioModel.instituicaoId = value;
            });
          },
        ),
        _buildGenericTextField(
          formato: MaskUtils.maskFormatterData(),
          label: 'Data de Inclusão no Órgão',
          onSave: (String? value) {
            usuarioModel.dataInclusao = parseDate(value!);
          },
          validator: (String? dataInclusao) {
            result = dataInclusaoIsValid(dataInclusao);
            if (result.isValid!) {
              return null;
            }
            return result.errorMessage;
          },
          keyboardType: TextInputType.datetime,
          prefixIcon: Icons.calendar_today,
        ),

        _buildGenericTextField(
          init: usuarioModel.telefone ?? '',
          formato: MaskUtils.maskTelefone(),
          label: 'Telefone',
          onSave: (String? value) {
            usuarioModel.telefone = value;
          },
          validator: (String? telefone) {
            result = telefoneIsValid(telefone);
            if (result.isValid!) {
              return null;
            }
            return result.errorMessage;
          },
          keyboardType: TextInputType.datetime,
          prefixIcon: Icons.calendar_today,
        ),
        _buildDropdownField(
          lista: estados,
          model: estados,
          label: 'Estado de Origem',
          value: selectedEstadoOrigemId ?? 1,
          onChanged: (value) {
            setState(() {
              selectedEstadoOrigemId = value;
              usuarioModel.estadoOrigemId = value;
            });
          },
        ),

        SizedBox(height: 10.h),
        //    usuarioModel.identidadeFuncional == null
        // Container(
        //   height: 55.h,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     color: Colors.grey[300],
        //   ),
        //   child: const Center(
        //     child: Text(
        //       'Nenhuma foto selecionada.',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(color: Colors.grey),
        //     ),
        //   ),
        // ),
        // : ClipRRect(
        //     borderRadius: BorderRadius.circular(10.0),
        //     child: Image.file(
        //       usuarioModel.identidadeFuncional!,
        //       height: 70,
        //       width: double.infinity,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // SizedBox(
        //   height: 10.h,
        // ),
        SizedBox(
          key: const Key('foto'),
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: null,
            //  onPressed: _pickImage,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Tirar Foto da Identidade Funcional'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cAccentColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagina3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // continua aqui
            children: List.generate(estados?.length ?? 0, (index) {
              final estado = estados?[index];
              final bool isSelected =
                  estadosSelecionados.contains(estado?.sigla);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    final sigla = estado?.sigla;
                    final id = estado?.id;

                    if (sigla == null || id == null) return;

                    if (estadosSelecionados.contains(sigla)) {
                      estadosSelecionados.remove(sigla);
                      usuarioModel.locais?.remove(id);
                    } else {
                      estadosSelecionados.add(sigla);
                      usuarioModel.locais ??= [];
                      usuarioModel.locais!.add(id);
                    }
                  });
                },
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: isSelected ? Colors.red : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          estado?.foto ?? "",
                          height: 60.h,
                          width: 60.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        estado?.nome ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  DateTime? parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      // Exemplo de parsing para o formato "dd/MM/yyyy"
      final parts = value.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      // Trate erros de parsing aqui
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      await UserController.cadastrarUser(context, usuarioModel);

      setState(() {
        _isLoading = false;
      });
    }
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

  Widget _buildDropdownField({
    required String label,
    required int? value,
    required ValueChanged<int?> onChanged,
    required var model,
    required List? lista,
    IconData? icon,
  }) {
    return Padding(
      key: Key(label),
      padding: EdgeInsets.only(top: 14.h),
      child: DropdownButtonFormField2<int>(
        isExpanded: false,
        isDense: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon ?? Icons.location_on),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.borda20),
          ),
        ),
        value: value,
        onChanged: onChanged,
        items: lista?.map((model) {
          return DropdownMenuItem<int>(
            value: model.id,
            child: Text(model.nome),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Por favor, selecione um estado';
          }
          return null;
        },
      ),
    );
  }

  void _proxima() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if (_currentPage < _paginas.length - 1) {
        setState(() {
          _currentPage += 1;
        });
      } else {
        _submitForm();
      }
    }
  }

  void _voltar() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage -= 1;
      });
    }
  }
}

class NavegacaoButtons extends StatelessWidget {
  final int currentPage;
  final int paginaLength;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const NavegacaoButtons(
      {super.key,
      required this.currentPage,
      required this.onNext,
      required this.onPrevious,
      required this.paginaLength});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentPage > 0)
          ElevatedButton(
            onPressed: onPrevious,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cAccentColor, // Color for the button
              foregroundColor: Colors.white, // Color for the text
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: const Text('Voltar'),
            ),
          ),
        ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cAccentColor, // Color for the button
              foregroundColor: Colors.white, // Color for the text
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                    currentPage == paginaLength - 1 ? 'Finalizar' : 'Próximo')))
      ],
    );
  }
}
