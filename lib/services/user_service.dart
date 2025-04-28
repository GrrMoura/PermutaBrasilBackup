import 'package:dio/dio.dart';
import 'package:permuta_brasil/models/recuperar_senha_model.dart';
import 'package:permuta_brasil/models/usuario_model.dart';
import 'package:permuta_brasil/services/api_service.dart';
import 'package:permuta_brasil/services/autenticacao_service.dart';
import 'package:permuta_brasil/services/request_service.dart';
import 'package:permuta_brasil/utils/enums/enums.dart';

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
