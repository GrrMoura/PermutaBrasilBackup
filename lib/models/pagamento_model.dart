import 'package:permutabrasil/models/plano_model.dart';

class PagamentoModel {
  String? id;
  String? faturaId;
  String? status;
  String? qrcodeImage;
  String? qrcodeTexto;
  int? valorSolicitadoCents;
  DateTime? dataHoraCriacao;
  PlanoModel? plano;

  PagamentoModel({
    this.id,
    this.faturaId,
    this.status,
    this.qrcodeImage,
    this.qrcodeTexto,
    this.valorSolicitadoCents,
    this.dataHoraCriacao,
    this.plano,
  });

  factory PagamentoModel.fromMap(Map<String, dynamic> map) {
    return PagamentoModel(
      id: map['id'],
      faturaId: map['faturaId'],
      status: map['status'],
      qrcodeImage: map['qrcodeImage'],
      qrcodeTexto: map['qrcodeTexto'],
      valorSolicitadoCents: map['valorSolicitadoCents'],
      plano: map['plano'] != null ? PlanoModel.fromJson(map['plano']) : null,
      dataHoraCriacao: map['dataHoraCriacao'] != null
          ? DateTime(
              map['dataHoraCriacao'][0],
              map['dataHoraCriacao'][1],
              map['dataHoraCriacao'][2],
              map['dataHoraCriacao'][3],
              map['dataHoraCriacao'][4],
              map['dataHoraCriacao'][5],
              map['dataHoraCriacao'][6] ~/
                  1000, // nanosegundos -> microssegundos
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'faturaId': faturaId,
      'status': status,
      'qrcodeImage': qrcodeImage,
      'qrcodeTexto': qrcodeTexto,
      'valorSolicitadoCents': valorSolicitadoCents,
      'dataHoraCriacao': dataHoraCriacao?.toIso8601String(),
    };
  }
}
