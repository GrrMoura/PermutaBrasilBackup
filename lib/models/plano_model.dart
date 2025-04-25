class PlanoModel {
  int? id;
  String? nome;
  String? descricao;
  bool? ativo;
  double? valor;

  PlanoModel({this.id, this.nome, this.ativo, this.descricao, this.valor});

  factory PlanoModel.fromJson(Map<String, dynamic> json) {
    return PlanoModel(
      id: json['id'],
      nome: json['nome'],
      ativo: json['ativo'],
      descricao: json['descricao'],
      valor: (json['valor'] != null)
          ? double.tryParse(json['valor'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'Id': id, 'Nome': nome, 'ativo': ativo, 'Descricao': descricao};
  }
}
