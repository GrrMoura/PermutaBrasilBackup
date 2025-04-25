// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permuta_brasil/models/pagamento_model.dart';
import 'package:permuta_brasil/services/dispositivo_service.dart';
import 'package:permuta_brasil/services/pagamento_service.dart';
import 'package:permuta_brasil/utils/erro_handler.dart';

class PagamentoController {
  static Future<PagamentoModel?> buyCredit(
      {required BuildContext context,
      required int idUsuario,
      required int idPlano}) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return null;
    }

    Response response = await PagamentoService.buyCredits(idUsuario, idPlano);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return null;
    }
    return PagamentoModel.fromMap(response.data);
  }
}
