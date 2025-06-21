// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permutabrasil/models/plano_model.dart';
import 'package:permutabrasil/models/recuperar_senha_model.dart';
import 'package:permutabrasil/models/redefinir_senha_model.dart';
import 'package:permutabrasil/models/usuario_model.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/rotas/app_screens_path.dart';
import 'package:permutabrasil/services/dispositivo_service.dart';
import 'package:permutabrasil/utils/app_constantes.dart';
import 'package:permutabrasil/utils/app_snack_bar.dart';
import 'package:permutabrasil/utils/erro_handler.dart';
import 'package:permutabrasil/viewModel/gastos_view_model.dart';
import 'package:permutabrasil/viewModel/match_view_model.dart';
import 'package:permutabrasil/viewModel/pagamento_view_model.dart';
import 'package:permutabrasil/viewModel/profissional_view_model.dart';
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

  static Future<void> alterarDadosPessoais(
      BuildContext context, UsuarioModel model) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) return;

    Response response = await UserService.alterarDadosPessoais(model);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return;
    }

    Generic.snackBar(
      context: context,
      mensagem: "Dados pessoais atualizados com sucesso",
      tipo: AppName.sucesso,
      duracao: 2,
    );
  }

  static Future<bool> alterarLocais(
      BuildContext context, List<int> estadoIds) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return false;
    }

    Response response = await UserService.alterarLocais(estadoIds);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return false;
    }

    return true;
  }

  static Future<void> alterarSenhaInterna(
      BuildContext context, RedefinirSenhaModel model) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) return;

    Response response = await UserService.alterarSenhaInterna(model);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return;
    }

    Generic.snackBar(
      context: context,
      mensagem: "Senha alterada com sucesso",
      tipo: AppName.sucesso,
      duracao: 2,
    );
  }

  static Future<void> alterarStatusPerfil(
      BuildContext context, WidgetRef ref) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return;
    }

    Response response = await UserService.alterarStatus();

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return;
    }
    final profissional = ref.read(profissionalProvider);
    ref.read(profissionalProvider.notifier).state =
        profissional?.copyWith(visivelMatch: !profissional.visivelMatch);

    Generic.snackBar(
      context: context,
      mensagem: "Status de visibilidade atualizado com sucesso!",
      tipo: AppName.sucesso,
      duracao: 2,
    );
    return;
  }

  static Future<void> redefinirSenha(
      BuildContext context, RedefinirSenhaModel model) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) return;

    Response response = await UserService.redefinirSenha(model);

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return;
    }

    Generic.snackBar(
      context: context,
      mensagem: "Senha redefinida com sucesso",
      tipo: AppName.sucesso,
      duracao: 2,
    );

    await Future.delayed(const Duration(seconds: 2));

    context.go(AppRouterName.login);
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

  static Future<List<GastosViewModel>?> pegarHistoricoConsumo(
      BuildContext context) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return null;
    }

    Response response = await UserService.pegarHistoricoConsumo();

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return null;
    }

    List<dynamic> data = response.data;
    return data.map((item) => GastosViewModel.fromJson(item)).toList();
  }

  static Future<List<PagamentoViewModel>?> buscarPagamentos(
      BuildContext context) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return null;
    }

    Response response = await UserService.pegarHistoricoCompras();

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return null;
    }

    // Converte resposta em lista de PagamentoModel
    List<dynamic> data = response.data;
    return data.map((item) => PagamentoViewModel.fromJson(item)).toList();
  }

  static Future<List<MatchViewModel>?> getMatches(BuildContext context) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return null;
    }

    Response response = await UserService.getMatches();

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return null;
    }

    List<dynamic> data = response.data;
    return data
        .map((item) => MatchViewModel.fromJson(item['profissional']))
        .toList();
  }

  static Future<ProfissionalViewModel?>? buscarProfissional(
      BuildContext context, WidgetRef ref) async {
    // Verifica conexão
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return null;
    }

    // Faz a requisição
    Response response = await UserService.buscarProfissional();

    // Trata erro se necessário
    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return null;
    }

    // Converte resposta em lista de UsuarioDestinoViewModel
    return ProfissionalViewModel.fromJson(response.data);
  }
}
