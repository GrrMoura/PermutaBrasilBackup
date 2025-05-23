import 'package:permutabrasil/models/plano_model.dart';

class PagamentoViewModel {
  final String id;
  final String faturaId;
  final String status;
  final String qrcodeImage;
  final String qrcodeTexto;
  final int valorSolicitadoCents;
  final DateTime dataHoraCriacao;
  final PlanoModel plano;
  final String statusFormatado;

  PagamentoViewModel({
    required this.id,
    required this.faturaId,
    required this.status,
    required this.qrcodeImage,
    required this.qrcodeTexto,
    required this.valorSolicitadoCents,
    required this.dataHoraCriacao,
    required this.plano,
    required this.statusFormatado,
  });

  factory PagamentoViewModel.fromJson(Map<String, dynamic> json) {
    return PagamentoViewModel(
      id: json['id'],
      faturaId: json['faturaId'],
      status: json['status'],
      qrcodeImage: json['qrcodeImage'],
      qrcodeTexto: json['qrcodeTexto'],
      valorSolicitadoCents: json['valorSolicitadoCents'],
      dataHoraCriacao: DateTime.parse(json['dataHoraCriacao']),
      plano: PlanoModel.fromJson(json['plano']),
      statusFormatado: json['statusFormatado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'faturaId': faturaId,
      'status': status,
      'qrcodeImage': qrcodeImage,
      'qrcodeTexto': qrcodeTexto,
      'valorSolicitadoCents': valorSolicitadoCents,
      'dataHoraCriacao': dataHoraCriacao.toIso8601String(),
      'plano': plano.toJson(),
      'statusFormatado': statusFormatado,
    };
  }
}
