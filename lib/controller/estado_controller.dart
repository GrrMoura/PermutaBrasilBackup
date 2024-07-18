import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:permuta_brasil/models/estado_model.dart';
import 'package:permuta_brasil/services/estado_service.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';
import 'package:permuta_brasil/services/dispositivo_service.dart';

class EstadoController {
  static Future<List<EstadoModel>> getEstados(BuildContext context) async {
    await _verificarConexao(context);

    try {
      Response response = await EstadoService.getEstados();

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<EstadoModel> estados = EstadoModel.fromJsonList(data);
        return estados;
      } else {
        _handleResponse(context, response);
        return [];
      }
    } catch (e) {
      debugPrint('Erro: $e');
      return [];
    }
  }

  static Future<void> _verificarConexao(BuildContext context) async {
    if (!await DispositivoService.hasInternetConnection()) {
      Generic.snackBar(
        context: context,
        mensagem: "Sem conexão com a internet.",
      );
      throw Exception("Sem conexão com a internet.");
    }
  }

  static void _handleResponse(BuildContext context, Response response) {
    if (response.statusCode == 200) {
      return;
    } else {
      return Generic.snackBar(
        context: context,
        mensagem: "${response.statusMessage}",
      );
    }
  }
}
