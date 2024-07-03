// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permuta_brasil/models/recuperar_senha_model.dart';
import 'package:permuta_brasil/models/usuario_model.dart';
import 'package:permuta_brasil/services/dispositivo_service.dart';
import 'package:permuta_brasil/utils/app_names.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';
import '../services/user_service.dart';
import 'package:dio/dio.dart';

class UserController {
  static Future<void> cadastrarUser(
      BuildContext context, UsuarioModel model) async {
    bool conectado = await DispositivoService.hasInternetConnection();

    if (!conectado) {
      Generic.snackBar(
          context: context,
          mensagem: "Sem conexão com a internet.",
          tipo: AppName.erro,
          duracao: 2);
      return;
    }

    try {
      Response response = await UserService.cadastrarUsuario(model);

      if (response.statusCode == 200) {
        // Sucesso no cadastro

        // context.push(AppRouterName.cadastro);
      } else {
        // Tratar erros de resposta do servidor
        Generic.snackBar(
            context: context,
            mensagem: "Um erro inesperado",
            tipo: AppName.erro,
            duracao: 2);
      }
    } catch (e) {
      // Tratar erros de conexão ou outros erros não esperados
      Generic.snackBar(
          context: context,
          mensagem: "Um erro inesperado ocorreu.",
          tipo: AppName.erro,
          duracao: 2);
    } finally {}
  }

  static Future<void> recuperarSenha(
      BuildContext context, RecuperarSenhaModel model) async {
    bool conectado = await DispositivoService.hasInternetConnection();

    if (!conectado) {
      Generic.snackBar(
          context: context,
          mensagem: "Sem conexão com a internet.",
          tipo: AppName.erro,
          duracao: 2);
      return;
    }

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
      // Tratar erros de conexão ou outros erros não esperados
      Generic.snackBar(
          context: context,
          mensagem: "Um erro inesperado ocorreu.",
          tipo: AppName.erro,
          duracao: 2);
    }
  }
}
