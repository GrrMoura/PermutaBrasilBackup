class PermissaoModel {
  String permissao;

  PermissaoModel({required this.permissao});

  factory PermissaoModel.fromJson(Map<String, dynamic> json) {
    return PermissaoModel(permissao: json['permissao'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'permissao': permissao};
  }

  static List<PermissaoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PermissaoModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<PermissaoModel> permissoes) {
    return permissoes.map((permissao) => permissao.toJson()).toList();
  }
}
