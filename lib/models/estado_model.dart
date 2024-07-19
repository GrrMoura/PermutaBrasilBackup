class EstadoModel {
  int id;
  String nome;
  String sigla;
  String? foto;

  EstadoModel({
    required this.id,
    required this.nome,
    required this.sigla,
    required this.foto,
  });

  factory EstadoModel.fromJson(Map<String, dynamic> json) {
    return EstadoModel(
      id: json['id'] as int,
      nome: json['nome'] as String,
      sigla: json['sigla'] as String,
      foto: json['foto'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'sigla': sigla,
      'foto': foto,
    };
  }

  static List<EstadoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EstadoModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<EstadoModel> estados) {
    return estados.map((estado) => estado.toJson()).toList();
  }
}
