// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/models/autenticao_model.dart';
import 'package:permuta_brasil/models/sessao_model.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/services/autenticacao_service.dart';
import 'package:permuta_brasil/services/dispositivo_service.dart';
import 'package:permuta_brasil/utils/erro_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacaoController {
  static Future<void> logar(
      BuildContext context, AutenticacaoModel model) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return;
    }

    try {
      Response response = await AutenticacaoService.logar(model);

      if (response.statusCode != 200) {
        ErroHandler.tratarErro(context, response);
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Sessao.fromJson(response.data).setSession(prefs, model);
      context.push(AppRouterName.homeController);
    } catch (e) {
      debugPrint('erro: $e');
    }
  }
}
