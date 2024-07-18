// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permuta_brasil/controller/user_controller.dart';
import 'package:permuta_brasil/data/sqflite_helper.dart';
import 'package:permuta_brasil/models/usuario_model.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/mask_utils.dart';
import 'package:permuta_brasil/utils/styles.dart';
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

  final ImagePicker _picker = ImagePicker();
  DatabaseHelper db = DatabaseHelper();

  List<Map<String, dynamic>>? estados;

  int? _selectedEstadoOrigem;
  int? _selectedEstadoDestino;

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  Future<void> _loadEstados() async {
    estados = await db.getEstados();
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        //  usuarioModel.identidadeFuncional = File(pickedFile.path);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildGenericTextField(
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
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.person,
                ),
                _buildGenericTextField(
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
                    usuarioModel.dataNascimento = DateTime.tryParse(value!);
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
                  formato: MaskUtils.maskFormatterData(),
                  label: 'Data de Inclusão no Órgão',
                  onSave: (String? value) {
                    usuarioModel.dataInclusao = DateTime.tryParse(value!);
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
                _buildDropdownField(
                  label: 'Estado de Origem',
                  value: _selectedEstadoOrigem,
                  onChanged: (value) {
                    setState(() {
                      _selectedEstadoOrigem = value;
                      usuarioModel.estadoOrigemId = value;
                    });
                  },
                ),
                // _buildDropdownField(
                //   label: 'Estado de Destino',
                //   value: _selectedEstadoDestino,
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedEstadoDestino = value;
                //       usuarioModel.instituicoesId = value;
                //     });
                //   },
                // ),
                // SizedBox(height: 10.h),
                // usuarioModel.identidadeFuncional == null
                //     ? Container(
                //         height: 70,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10.0),
                //           color: Colors.grey[300],
                //         ),
                //         child: const Center(
                //           child: Text(
                //             'Nenhuma foto selecionada.',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(color: Colors.grey),
                //           ),
                //         ),
                //       )
                //     : ClipRRect(
                //         borderRadius: BorderRadius.circular(10.0),
                //         child: Image.file(
                //           usuarioModel.identidadeFuncional!,
                //           height: 70,
                //           width: double.infinity,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  key: const Key('foto'),
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _pickImage,
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
                SizedBox(height: 30.h),
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
              ],
            ),
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
    return Padding(
      key: Key(label),
      padding: EdgeInsets.only(top: 8.h),
      child: TextFormField(
        inputFormatters: [formato ?? MaskUtils.padrao()],
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
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required int? value,
    required ValueChanged<int?> onChanged,
  }) {
    return Padding(
      key: Key(label),
      padding: EdgeInsets.only(top: 14.h),
      child: DropdownButtonFormField<int>(
        menuMaxHeight: 300,
        isDense: true,
        decoration: InputDecoration(
          labelText: label, //TODO: fazer drop down e add mais de uma opcao
          prefixIcon: const Icon(Icons.location_on),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        value: value,
        onChanged: onChanged,
        items: estados?.map((estado) {
          return DropdownMenuItem<int>(
            value: estado['id'],
            child: Text(estado['nome']),
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

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      // Simulação de carga ou chamada assíncrona
      await Future.delayed(const Duration(seconds: 4));
      await UserController.cadastrarUser(context, usuarioModel);

      setState(() {
        _isLoading = false;
      });
    }
  }
}

// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:permuta_brasil/controller/estado_controller.dart';
// import 'package:permuta_brasil/controller/user_controller.dart';
// import 'package:permuta_brasil/data/sqflite_helper.dart';
// import 'package:permuta_brasil/models/estado_model.dart';
// import 'package:permuta_brasil/models/usuario_model.dart';
// import 'package:permuta_brasil/utils/app_colors.dart';
// import 'package:permuta_brasil/utils/mask_utils.dart';
// import 'package:permuta_brasil/utils/styles.dart';
// import 'package:permuta_brasil/utils/validator.dart';

// class CadastroScreen extends StatefulWidget {
//   const CadastroScreen({super.key});

//   @override
//   CadastroScreenState createState() => CadastroScreenState();
// }

// class CadastroScreenState extends State<CadastroScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   UsuarioModel usuarioModel = UsuarioModel();
//   ValidationResult result = ValidationResult();
//   List<EstadoModel>? estados = [];

//   final ImagePicker _picker = ImagePicker();
//   DatabaseHelper db = DatabaseHelper();

//   int? selectedEstadoOrigemId;
//   int? selectedEstadoDestinoId;

//   @override
//   void initState() {
//     super.initState();
//     _loadEstados();
//   }

//   Future<void> _loadEstados() async {
//     List<EstadoModel> fetchedEstados =
//         await EstadoController.getEstados(context);
//     setState(() {
//       estados = fetchedEstados;
//     });
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         //   usuarioModel.identidadeFuncional = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Cadastro',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.cAccentColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildGenericTextField(
//                   label: 'Nome',
//                   formato: MaskUtils.padrao(),
//                   onSave: (String? value) {
//                     usuarioModel.nome = value;
//                   },
//                   validator: (String? value) {
//                     result = stringIsValid(value!);
//                     if (result.isValid!) {
//                       return null;
//                     }
//                     return result.errorMessage;
//                   },
//                   keyboardType: TextInputType.number,
//                   prefixIcon: Icons.person,
//                 ),
//                 _buildGenericTextField(
//                   label: 'CPF',
//                   formato: MaskUtils.maskFormatterCpf(),
//                   onSave: (String? value) {
//                     usuarioModel.cpf = value;
//                   },
//                   validator: (String? value) {
//                     result = cpfIsValid(value);
//                     if (result.isValid!) {
//                       return null;
//                     }
//                     return result.errorMessage;
//                   },
//                   keyboardType: TextInputType.number,
//                   prefixIcon: Icons.assignment_ind,
//                 ),
//                 _buildGenericTextField(
//                   label: 'Data de Nascimento',
//                   formato: MaskUtils.maskFormatterData(),
//                   onSave: (String? value) {
//                     usuarioModel.dataNascimento = DateTime.tryParse(value!);
//                   },
//                   validator: (String? dtNascimento) {
//                     result = dataNascimentoIsValid(dtNascimento);
//                     if (result.isValid!) {
//                       return null;
//                     }
//                     return result.errorMessage;
//                   },
//                   keyboardType: TextInputType.datetime,
//                   prefixIcon: Icons.calendar_today,
//                 ),
//                 _buildGenericTextField(
//                   formato: MaskUtils.maskFormatterData(),
//                   label: 'Data de Inclusão no Órgão',
//                   onSave: (String? value) {
//                     usuarioModel.dataInclusao = DateTime.tryParse(value!);
//                   },
//                   validator: (String? dataInclusao) {
//                     result = dataInclusaoIsValid(dataInclusao);
//                     if (result.isValid!) {
//                       return null;
//                     }
//                     return result.errorMessage;
//                   },
//                   keyboardType: TextInputType.datetime,
//                   prefixIcon: Icons.calendar_today,
//                 ),
//                 _buildDropdownField(
//                   label: 'Estado de Origem',
//                   value: selectedEstadoOrigemId ?? 1,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedEstadoOrigemId = value;
//                       usuarioModel.estadoOrigemId = value;
//                     });
//                   },
//                 ),
//                 _buildDropdownField(
//                   label: 'Estado de Destino',
//                   value: selectedEstadoDestinoId,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedEstadoDestinoId = value;
//                       usuarioModel.estadoOrigemId = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 10.h),
//                 //    usuarioModel.identidadeFuncional == null
//                 // Container(
//                 //   height: 55.h,
//                 //   decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(10.0),
//                 //     color: Colors.grey[300],
//                 //   ),
//                 //   child: const Center(
//                 //     child: Text(
//                 //       'Nenhuma foto selecionada.',
//                 //       textAlign: TextAlign.center,
//                 //       style: TextStyle(color: Colors.grey),
//                 //     ),
//                 //   ),
//                 // ),
//                 // : ClipRRect(
//                 //     borderRadius: BorderRadius.circular(10.0),
//                 //     child: Image.file(
//                 //       usuarioModel.identidadeFuncional!,
//                 //       height: 70,
//                 //       width: double.infinity,
//                 //       fit: BoxFit.cover,
//                 //     ),
//                 //   ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 SizedBox(
//                   key: const Key('foto'),
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                     onPressed: _pickImage,
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text('Tirar Foto da Identidade Funcional'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.cAccentColor,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _submitForm,
//                     style: Styles().elevatedButtonStyle(),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white))
//                         : const Text('Enviar'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGenericTextField({
//     required String label,
//     required void Function(String?) onSave,
//     required String? Function(String?)? validator,
//     required IconData prefixIcon,
//     MaskTextInputFormatter? formato,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Padding(
//       key: Key(label),
//       padding: EdgeInsets.only(top: 8.h),
//       child: TextFormField(
//         inputFormatters: [formato ?? MaskUtils.padrao()],
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(prefixIcon),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         keyboardType: keyboardType,
//         onSaved: onSave,
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildDropdownField({
//     required String label,
//     required int? value,
//     required ValueChanged<int?> onChanged,
//   }) {
//     return Padding(
//       key: Key(label),
//       padding: EdgeInsets.only(top: 14.h),
//       child: DropdownButtonFormField<int>(
//         menuMaxHeight: 300,
//         isDense: true,
//         decoration: InputDecoration(
//           labelText: label, //TODO: fazer drop down e add mais de uma opcao
//           prefixIcon: const Icon(Icons.location_on),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         value: value,
//         onChanged: onChanged,
//         items: estados?.map((estado) {
//           return DropdownMenuItem<int>(
//             value: estado.id,
//             child: Text(estado.nome),
//           );
//         }).toList(),
//         validator: (value) {
//           if (value == null) {
//             return 'Por favor, selecione um estado';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   void _submitForm() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       _formKey.currentState?.save();

//       setState(() {
//         _isLoading = true;
//       });

//       // Simulação de carga ou chamada assíncrona
//       await Future.delayed(const Duration(seconds: 4));
//       await UserController.cadastrarUser(context, usuarioModel);

//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
// }
