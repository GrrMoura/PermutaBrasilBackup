import 'package:dio/dio.dart';
import 'package:permuta_brasil/models/autenticao_model.dart';
import 'package:permuta_brasil/services/api_service.dart';
import 'package:permuta_brasil/services/request_service.dart';

class AutenticacaoService {
  static Future<Response> logar(AutenticacaoModel model) async {
    var url = ApiServices.concatApiUrl("login");

    var options = Options(headers: {});

    var response = await RequestService.postOptions(
        url: url, data: model.toJson(), options: options);

    return response;
  }
}
