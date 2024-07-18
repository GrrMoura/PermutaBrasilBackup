class UsuarioModel {
  String? nome;
  String? email;
  String? cpf;
  DateTime? dataNascimento;
  int? estadoOrigemId;
  DateTime? dataInclusao;
  List<int>? instituicoesId;

  //File? identidadeFuncional;

  UsuarioModel(
      {this.cpf,
      //  this.identidadeFuncional,
      this.dataNascimento,
      this.instituicoesId,
      this.estadoOrigemId,
      this.email,
      this.dataInclusao,
      this.nome});

  Map<String, dynamic> toJson() => {
        'cpf': cpf,
        //  'identidadeFuncional': identidadeFuncional,
        'dataNascimento': dataNascimento!.toIso8601String(),
        'instituicoesId': instituicoesId,
        'estadoOrigemId': estadoOrigemId,
        'email': email,
        'dataInclusao': dataInclusao!.toIso8601String(),
        'nome': nome,
      };

  static UsuarioModel fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      cpf: json['cpf'],
      nome: json['nome'],
      // identidadeFuncional: json['identidadeFuncional'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      instituicoesId: List<int>.from(json['instituicoesId'] ?? []),
      estadoOrigemId: json['estadoOrigemId'],
      email: json['email'],
      dataInclusao: DateTime.parse(json['dataInclusao']),
    );
  }
}
