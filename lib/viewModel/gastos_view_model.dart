class GastosViewModel {
  final String id;
  final String tipo;
  final double valor;
  final String descricao;
  final DateTime dataHora;

  GastosViewModel({
    required this.id,
    required this.tipo,
    required this.valor,
    required this.descricao,
    required this.dataHora,
  });

  factory GastosViewModel.fromJson(Map<String, dynamic> json) {
    return GastosViewModel(
      id: json['id'],
      tipo: json['tipo'],
      valor: (json['valor'] as num).toDouble(),
      descricao: json['descricao'],
      dataHora: DateTime.parse(json['dataHora']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'valor': valor,
      'descricao': descricao,
      'dataHora': dataHora.toIso8601String(),
    };
  }
}
