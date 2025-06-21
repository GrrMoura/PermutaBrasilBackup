import 'package:permutabrasil/models/estado_model.dart';

class MatchViewModel {
  int idUsuario;
  String? cpf;
  String? dataNascimento;
  String? dataInclusao;
  String? telefone;
  String? nome;
  String? patenteClase;
  EstadoModel estado;
  // List<EstadoModel> destinos;

  MatchViewModel({
    required this.idUsuario,
    this.cpf,
    this.dataNascimento,
    this.dataInclusao,
    this.telefone,
    this.nome,
    this.patenteClase,
    required this.estado,

    // required this.destinos,
  });

  factory MatchViewModel.fromJson(Map<String, dynamic> json) {
    return MatchViewModel(
      idUsuario: json['idUsuario'] as int,
      cpf: json['cpf'] ?? "",
      dataNascimento: json['dataNascimento'] ?? "",
      dataInclusao: json['dataInclusao'] ?? "",
      telefone: json['telefone'] ?? '',
      nome: json['nome'] ?? "",
      patenteClase: json['patenteClase'] ?? "",
      estado: json['estado'] != null
          ? EstadoModel.fromJson(json['estado'] as Map<String, dynamic>)
          : EstadoModel(id: 0, nome: '', sigla: '', foto: null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'dataInclusao': dataInclusao,
      'telefone': telefone,
      'nome': nome,
      'patenteClase': patenteClase,
      'estado': estado.toJson(),
      //'destinos': destinos.map((d) => d.toJson()).toList(),
    };
  }
}
