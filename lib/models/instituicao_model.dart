class InstituicaoModel {
  final int id;
  final String nome;
  final String sigla;

  InstituicaoModel({
    required this.id,
    required this.nome,
    required this.sigla,
  });

  factory InstituicaoModel.fromJson(Map<String, dynamic> json) {
    return InstituicaoModel(
      id: json['id'] as int,
      nome: json['name'] as String,
      sigla: json['sigla'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'sigla': sigla,
    };
  }

  static List<InstituicaoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => InstituicaoModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<InstituicaoModel> instituicoes) {
    return instituicoes.map((instituicao) => instituicao.toJson()).toList();
  }
}
