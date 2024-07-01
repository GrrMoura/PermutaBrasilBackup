import 'package:dio/dio.dart';
import 'package:permuta_brasil/models/recuperar_senha_model.dart';
import 'package:permuta_brasil/models/usuario_model.dart';
import 'package:permuta_brasil/services/api_service.dart';
import 'package:permuta_brasil/services/request_service.dart';

class UserService {
  static Future<Response> cadastrarUsuario(UsuarioModel model) async {
    var url = ApiServices.concatIntranetUrl(
        "Usuarios/Cadastrar"); // URL para o endpoint de cadastro de usuário

    // Montagem do cabeçalho
    var options = Options(
      headers: {},
    );

    // Envio da requisição POST com os dados do usuário
    var response = await RequestService.postOptions(
      url: url,
      //data: UserModel.fromJson(json),
      options: options,
    );

    return response;
  }

  static Future<Response> recuperarSenha(RecuperarSenhaModel model) async {
    var url = ApiServices.concatIntranetUrl(
        "Usuarios/resetarSenha"); // URL para o endpoint de cadastro de usuário

    // Montagem do cabeçalho
    var options = Options(
      headers: {},
    );

    // Envio da requisição POST com os dados do usuário
    var response = await RequestService.postOptions(
      url: url,
      //data: UserModel.fromJson(json),
      options: options,
    );

    return response;
  }
}
