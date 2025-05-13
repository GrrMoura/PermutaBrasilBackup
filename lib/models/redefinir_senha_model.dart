class RedefinirSenhaModel {
  String? token;
  String? novaSenha;
  String? confirmarSenha;

  RedefinirSenhaModel({
    this.token,
    this.novaSenha,
    this.confirmarSenha,
  });

  factory RedefinirSenhaModel.fromJson(Map<String, dynamic> json) {
    return RedefinirSenhaModel(
      token: json['token'] as String,
      novaSenha: json['novaSenha'] as String,
      confirmarSenha: json['confirmarSenha'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'novaSenha': novaSenha,
      'confirmarSenha': confirmarSenha,
    };
  }

  static List<RedefinirSenhaModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RedefinirSenhaModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<RedefinirSenhaModel> list) {
    return list.map((item) => item.toJson()).toList();
  }
}
