import 'package:dio/dio.dart';
import 'package:permutabrasil/models/recuperar_senha_model.dart';
import 'package:permutabrasil/models/redefinir_senha_model.dart';
import 'package:permutabrasil/models/usuario_model.dart';
import 'package:permutabrasil/services/api_service.dart';
import 'package:permutabrasil/services/autenticacao_service.dart';
import 'package:permutabrasil/services/request_service.dart';
import 'package:permutabrasil/utils/enums/enums.dart';

class UserService {
  static Future<Response> cadastrarUsuario(UsuarioModel model) async {
    var url = ApiServices.concatApiUrl("publico/cadastrar");

    var options = Options(headers: {});

    var response = await RequestService.postOptions(
        url: url, options: options, data: model.toJson());

    return response;
  }

  static Future<Response> pegarPlanos() async {
    var url = ApiServices.concatApiUrl("credito/planos");

    var options =
        await AutenticacaoService.getCabecalho(TipoCabecalho.requisicao);

    var response = await RequestService.getOptions(url: url, options: options);

    return response;
  }

  static Future<Response> redefinirSenha(RedefinirSenhaModel model) async {
    var url = ApiServices.concatApiUrl("usuario/redefinir-senha");
    var response =
        await RequestService.postSemOptions(url: url, data: model.toJson());

    return response;
  }

  static Future<Response> alterarSenhaInterna(RedefinirSenhaModel model) async {
    var url = ApiServices.concatApiUrl("usuario/alterar-senha");
    var options =
        await AutenticacaoService.getCabecalho(TipoCabecalho.requisicao);
    var response = await RequestService.postOptions(
        url: url, data: model.toJson(), options: options);

    return response;
  }

  static Future<Response> alterarDadosPessoais(UsuarioModel model) async {
    var url = ApiServices.concatApiUrl("usuario/alterar-dados-pessoais");
    var options =
        await AutenticacaoService.getCabecalho(TipoCabecalho.requisicao);

    var response = await RequestService.postOptions(
      url: url,
      data: model.toJson(),
      options: options,
    );

    return response;
  }

  static Future<Response> getMatches() async {
    var url = ApiServices.concatApiUrl("usuario/matches");

    var options =
        await AutenticacaoService.getCabecalho(TipoCabecalho.requisicao);

    var response = await RequestService.getOptions(url: url, options: options);

    return response;
  }

  static Future<Response> cadastrarEstadosDeInteresse(
      List<int> estadoIds) async {
    var url = ApiServices.concatApiUrl("usuario/locais");

    var options = Options(headers: {});

    var response = await RequestService.postOptions(
      url: url,
      options: options,
      data: {'locais': estadoIds},
    );

    return response;
  }

  static Future<Response> recuperarSenha(RecuperarSenhaModel model) async {
    var url = ApiServices.concatApiUrl(
        "publico/recuperar/senha"); // URL para o endpoint de cadastro de usuário

    // Montagem do cabeçalho
    var options = Options(
      headers: {},
    );

    // Envio da requisição POST com os dados do usuário
    var response = await RequestService.postOptions(
      url: url,
      data: model.toJson(),
      options: options,
    );

    return response;
  }
}
