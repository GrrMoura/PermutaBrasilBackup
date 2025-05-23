import 'package:permutabrasil/models/estado_model.dart';
import 'package:permutabrasil/models/instituicao_model.dart';
import 'package:permutabrasil/models/usuario_model.dart';

class ProfissionalViewModel {
  int id;
  String cpf;
  String dataNascimento;
  String dataInclusao;
  String telefone;
  String? patenteClasse;
  String imagemFuncionalBase64;
  bool visivelMatch;
  UsuarioModel usuario;
  EstadoModel estado;
  InstituicaoModel instituicao;
  List<EstadoModel> destinos;

  ProfissionalViewModel({
    required this.id,
    required this.cpf,
    required this.dataNascimento,
    required this.dataInclusao,
    required this.telefone,
    this.patenteClasse,
    required this.imagemFuncionalBase64,
    required this.visivelMatch,
    required this.usuario,
    required this.estado,
    required this.instituicao,
    required this.destinos,
  });

  ProfissionalViewModel copyWith({
    int? id,
    String? cpf,
    String? dataNascimento,
    String? dataInclusao,
    String? telefone,
    String? patenteClasse,
    String? imagemFuncionalBase64,
    bool? visivelMatch,
    UsuarioModel? usuario,
    EstadoModel? estado,
    InstituicaoModel? instituicao,
    List<EstadoModel>? destinos,
  }) {
    return ProfissionalViewModel(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      dataInclusao: dataInclusao ?? this.dataInclusao,
      telefone: telefone ?? this.telefone,
      patenteClasse: patenteClasse ?? this.patenteClasse,
      imagemFuncionalBase64:
          imagemFuncionalBase64 ?? this.imagemFuncionalBase64,
      visivelMatch: visivelMatch ?? this.visivelMatch,
      usuario: usuario ?? this.usuario,
      estado: estado ?? this.estado,
      instituicao: instituicao ?? this.instituicao,
      destinos: destinos ?? this.destinos,
    );
  }

  factory ProfissionalViewModel.fromJson(Map<String, dynamic> json) {
    return ProfissionalViewModel(
      id: json['id'],
      cpf: json['cpf'],
      dataNascimento: json['dataNascimento'],
      dataInclusao: json['dataInclusao'],
      telefone: json['telefone'],
      patenteClasse: json['patenteClasse'],
      imagemFuncionalBase64: json['imagemFuncionalBase64'],
      visivelMatch: json['visivelMatch'],
      usuario: UsuarioModel.fromJson(json['usuario']),
      estado: EstadoModel.fromJson(json['estado']),
      instituicao: InstituicaoModel.fromJson(json['instituicao']),
      destinos: (json['destinos'] as List<dynamic>)
          .map((e) => EstadoModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'dataInclusao': dataInclusao,
      'telefone': telefone,
      'patenteClasse': patenteClasse,
      'imagemFuncionalBase64': imagemFuncionalBase64,
      'visivelMatch': visivelMatch,
      'usuario': usuario.toJson(),
      'estado': estado.toJson(),
      'instituicao': instituicao.toJson(),
      'destinos': destinos.map((e) => e.toJson()).toList(),
    };
  }
}
