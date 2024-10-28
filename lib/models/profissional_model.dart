import 'package:permuta_brasil/models/estado_model.dart';
import 'package:permuta_brasil/models/instituicao_model.dart';
import 'package:permuta_brasil/models/usuario_model.dart';

class ProfissionalModel {
  int id;
  String cpf;
  String dataNascimento;
  String dataInclusao;
  UsuarioModel usuario;
  EstadoModel estado;
  InstituicaoModel instituicao;
  List<EstadoModel> destinos;

  ProfissionalModel({
    required this.id,
    required this.cpf,
    required this.dataNascimento,
    required this.dataInclusao,
    required this.usuario,
    required this.estado,
    required this.instituicao,
    required this.destinos,
  });

  factory ProfissionalModel.fromJson(Map<String, dynamic> json) {
    return ProfissionalModel(
      id: json['id'] as int,
      cpf: json['cpf'] as String,
      dataNascimento: json['dataNascimento'] as String,
      dataInclusao: json['dataInclusao'] as String,
      usuario: UsuarioModel.fromJson(json['usuario']),
      estado: EstadoModel.fromJson(json['estado']),
      instituicao: InstituicaoModel.fromJson(json['instituicao']),
      destinos: EstadoModel.fromJsonList(json['destinos'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'dataInclusao': dataInclusao,
      'usuario': usuario.toJson(),
      'estado': estado.toJson(),
      'instituicao': instituicao.toJson(),
      'destinos': EstadoModel.toJsonList(destinos),
    };
  }
}
