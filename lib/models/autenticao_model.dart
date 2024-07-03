class AutenticacaoModel {
  String? login;
  String? senha;

  AutenticacaoModel({
    this.login,
    this.senha,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'senha': senha,
    };
  }
}
