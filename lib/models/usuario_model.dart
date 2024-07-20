class UsuarioModel {
  String? nome;
  String? email;
  String? cpf;
  String? senha;
  String? confirmarSenha;
  DateTime? dataNascimento;
  int? estadoOrigemId;
  DateTime? dataInclusao;
  int? instituicaoId;

  //File? identidadeFuncional;

  UsuarioModel(
      {this.cpf,
      //  this.identidadeFuncional,
      this.dataNascimento,
      this.instituicaoId,
      this.estadoOrigemId,
      this.email,
      this.dataInclusao,
      this.confirmarSenha,
      this.senha,
      this.nome});

  Map<String, dynamic> toJson() => {
        'cpf': cpf,
        //  'identidadeFuncional': identidadeFuncional,
        'dataNascimento': dataNascimento!.toIso8601String(),
        'instituicaoId': instituicaoId,
        'estadoOrigemId': estadoOrigemId,
        'email': email,
        'dataInclusao': dataInclusao!.toIso8601String(),
        'nome': nome,
        'senha': senha
      };

  static UsuarioModel fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      cpf: json['cpf'],
      nome: json['nome'],
      // identidadeFuncional: json['identidadeFuncional'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      //  instituicoesId: List<int>.from(json['instituicoesId'] ?? []),
      estadoOrigemId: json['estadoOrigemId'],
      instituicaoId: json['instituicaoId'],
      email: json['email'],
      dataInclusao: DateTime.parse(json['dataInclusao']),
    );
  }
}
