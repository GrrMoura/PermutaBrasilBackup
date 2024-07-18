// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/models/autenticao_model.dart';
import 'package:permuta_brasil/models/sessao_model.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/services/autenticacao_service.dart';
import 'package:permuta_brasil/services/dispositivo_service.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacaoController {
  static Future<void> logar(
      BuildContext context, AutenticacaoModel model) async {
    await _verificarConexao(context);

    try {
      Response response = await AutenticacaoService.logar(model);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Sessao.fromJson(response.data).setSession(prefs, model);

        context.push(AppRouterName.home);
      } else {
        _handleResponse(context, response);
      }
    } catch (e) {
      debugPrint('erro: $e');
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
