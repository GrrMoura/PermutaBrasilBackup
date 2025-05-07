class AutenticacaoModel {
  String? login;
  String? senha;
  String? tokenFmc;

  AutenticacaoModel({this.login, this.senha, this.tokenFmc});

  Map<String, dynamic> toJson() {
    return {'login': login, 'senha': senha, 'fmc': tokenFmc};
  }
}
