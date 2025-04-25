// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/models/plano_model.dart';
import 'package:permuta_brasil/models/recuperar_senha_model.dart';
import 'package:permuta_brasil/models/usuario_model.dart';
import 'package:permuta_brasil/services/dispositivo_service.dart';
import 'package:permuta_brasil/utils/app_constantes.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';
import 'package:permuta_brasil/utils/erro_handler.dart';
import '../services/user_service.dart';
import 'package:dio/dio.dart';

class UserController {
  static Future<bool> cadastrarUser(
      BuildContext context, UsuarioModel model) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return false;
    }

    Response response = await UserService.cadastrarUsuario(model);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return false;
      //     Generic.snackBar(
      //       context: context,
      //       mensagem: "Cadastro realizado com sucesso",
      //       tipo: AppName.sucesso,
      //       duracao: 2);
      //  context.push(AppRouterName.login);
    }

    return true;
  }

  static Future<bool> cadastrarEstadosDeInteresse(
      BuildContext context, List<int> estadosId) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return false;
    }

    Response response =
        await UserService.cadastrarEstadosDeInteresse(estadosId);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return false;
      //     Generic.snackBar(
      //       context: context,
      //       mensagem: "Cadastro realizado com sucesso",
      //       tipo: AppName.sucesso,
      //       duracao: 2);
      //  context.push(AppRouterName.login);
    }

    return true;
  }

  static Future<void> recuperarSenha(
      BuildContext context, RecuperarSenhaModel model) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) return;

    Response response = await UserService.recuperarSenha(model);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return;
    }
    Generic.snackBar(
        context: context,
        mensagem: "Senha enviada para seu email ",
        tipo: AppName.sucesso,
        duracao: 2);
    context.pop();
  }

  static Future<List<PlanoModel>?> pegarPlanos(BuildContext context) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return null;
    }

    Response response = await UserService.pegarPlanos();

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return null;
    }

    List<dynamic> data = response.data;
    return data.map((item) => PlanoModel.fromJson(item)).toList();
  }
}
