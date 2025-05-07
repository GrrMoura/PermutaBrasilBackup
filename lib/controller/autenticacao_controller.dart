// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permutabrasil/data/SecureStorage/secure_storage_helper.dart';
import 'package:permutabrasil/models/autenticao_model.dart';
import 'package:permutabrasil/models/sessao_model.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/rotas/app_screens_path.dart';
import 'package:permutabrasil/services/autenticacao_service.dart';
import 'package:permutabrasil/services/dispositivo_service.dart';
import 'package:permutabrasil/utils/erro_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacaoController {
  static Future<void> logar(
      BuildContext context, AutenticacaoModel model, WidgetRef ref) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return;
    }
    String? tokenFcm = await SecureStorageHelper.getToken();
    model.tokenFmc = tokenFcm;
    try {
      Response response = await AutenticacaoService.logar(model);

      if (response.statusCode != 200) {
        ErroHandler.tratarErro(context, response);
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Sessao.fromJson(response.data).setSession(prefs, model);
      final creditos = response.data['usuario']['credito'] ?? 0;
      final nome = response.data['usuario']['nome'] ?? 0;

      ref.read(creditoProvider.notifier).state = creditos;
      ref.read(nomeProvider.notifier).state = nome;
      context.go(AppRouterName.homeController, extra: 1);
    } catch (e) {
      debugPrint('erro: $e');
    }
  }
}
