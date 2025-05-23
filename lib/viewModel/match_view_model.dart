import 'package:permutabrasil/models/estado_model.dart';
import 'package:permutabrasil/models/usuario_model.dart';

class MatchViewModel {
  int id;
  String cpf;
  String dataNascimento;
  String dataInclusao;
  String telefone;
  UsuarioModel usuario;
  EstadoModel estado;
  // List<EstadoModel> destinos;

  MatchViewModel({
    required this.id,
    required this.cpf,
    required this.dataNascimento,
    required this.dataInclusao,
    required this.telefone,
    required this.usuario,
    required this.estado,

    // required this.destinos,
  });

  factory MatchViewModel.fromJson(Map<String, dynamic> json) {
    return MatchViewModel(
      id: json['id'] as int,
      cpf: json['cpf'] as String,
      dataNascimento: json['dataNascimento'],
      dataInclusao: json['dataInclusao'],

      telefone: json['telefone'] as String,
      usuario: UsuarioModel.fromJson(json['usuario']),
      estado: EstadoModel.fromJson(json['estado']),
      // destinos: (json['destinos'] as List)
      //     .map((e) => EstadoModel.fromJson(e))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'dataInclusao': dataInclusao,
      'telefone': telefone,
      'usuario': usuario.toJson(),
      'estado': estado.toJson(),
      //'destinos': destinos.map((d) => d.toJson()).toList(),
    };
  }
}
