import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permutabrasil/utils/app_snack_bar.dart';

class ErroHandler {
  static void tratarErro(BuildContext context, Response response) {
    String mensagemErro;

    switch (response.statusCode) {
      case 400:
      case 409:
        mensagemErro = response.data['detail'] ?? "Conflito detectado.";
        break;

      case 403:
      case 401:
        mensagemErro =
            "Acesso proibido. Você não tem permissão para realizar esta ação.";
        break;
      case 504:
        mensagemErro = response.statusMessage ?? "Erro de desconhecido";
        break;

      case 500:
        mensagemErro = "Algo deu errado em nosso sistema.";
        break;
      default:
        mensagemErro =
            "Erro desconhecido. Código de status: ${response.statusCode}";
        break;
    }
    mensagemErro = "Ops! $mensagemErro";
    Generic.snackBar(context: context, mensagem: mensagemErro, duracao: 3);
  }
}
