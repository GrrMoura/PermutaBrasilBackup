import 'dart:io';

class UsuarioModel {
  String? cpf;
  File? identidadeFuncional;
  DateTime? dataNascimento;
  List<int>? idEstados; // Novo atributo para armazenar IDs de estados
  String? estadoOrigem;
  String? estadoDestino;
  DateTime? dataInclusao;

  UsuarioModel({
    this.cpf,
    this.identidadeFuncional,
    this.dataNascimento,
    this.idEstados,
    this.estadoOrigem,
    this.estadoDestino,
    this.dataInclusao,
  });

  Map<String, dynamic> toJson() => {
        'cpf': cpf,
        'identidadeFuncional': identidadeFuncional,
        'dataNascimento': dataNascimento!.toIso8601String(),
        'idEstados': idEstados,
        'estadoOrigem': estadoOrigem,
        'estadoDestino': estadoDestino,
        'dataInclusao': dataInclusao!.toIso8601String(),
      };

  static UsuarioModel fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      cpf: json['cpf'],
      identidadeFuncional: json['identidadeFuncional'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      idEstados: List<int>.from(json['idEstados'] ?? []),
      estadoOrigem: json['estadoOrigem'],
      estadoDestino: json['estadoDestino'],
      dataInclusao: DateTime.parse(json['dataInclusao']),
    );
  }
}
