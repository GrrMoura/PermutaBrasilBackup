// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/models/autenticao_model.dart';
import 'package:permuta_brasil/models/recuperar_senha_model.dart';
import 'package:permuta_brasil/models/usuario_model.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/services/dispositivo_service.dart';
import 'package:permuta_brasil/utils/app_names.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';
import '../services/user_service.dart';
import 'package:dio/dio.dart';

class UserController {
  static Future<void> cadastrarUser(
      BuildContext context, UsuarioModel model) async {
    await _verificarConexao(context);

    try {
      Response response = await UserService.cadastrarUsuario(model);

      if (response.statusCode == 200) {
        Generic.snackBar(
            context: context,
            mensagem: "Cadastro realizado com sucesso",
            tipo: AppName.sucesso,
            duracao: 2);
        context.push(AppRouterName.login);
      } else {
        _handleResponse(context, response);
      }
    } catch (e) {
      debugPrint('erro: $e');
    }
  }

  static Future<void> recuperarSenha(
      BuildContext context, RecuperarSenhaModel model) async {
    await _verificarConexao(context);

    try {
      Response response = await UserService.recuperarSenha(model);

      if (response.statusCode == 200) {
        // Sucesso ao recuperar a senha

        // context.push(AppRouterName.recuperacaoSenha);
      } else {
        // Tratar erros de resposta do servidor
        Generic.snackBar(
            context: context,
            mensagem: "Um erro inesperado.",
            tipo: AppName.erro,
            duracao: 2);
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
