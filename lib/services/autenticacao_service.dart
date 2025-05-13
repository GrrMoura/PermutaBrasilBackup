import 'package:dio/dio.dart';
import 'package:permutabrasil/models/autenticao_model.dart';
import 'package:permutabrasil/services/api_service.dart';
import 'package:permutabrasil/services/request_service.dart';
import 'package:permutabrasil/utils/app_constantes.dart';
import 'package:permutabrasil/utils/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacaoService {
  static Future<Response> logar(AutenticacaoModel model) async {
    var url = ApiServices.concatApiUrl("login");
    var response =
        await RequestService.postSemOptions(url: url, data: model.toJson());
    return response;
  }

  static Future<Options> getCabecalho(TipoCabecalho tipo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(PrefsKey.authToken) ?? "";
    Map<String, dynamic> headers = {"Accept": "application/json"};
    // Cabeçalhos padrões
    switch (tipo) {
      case TipoCabecalho.autenticacao:
        headers["Content-Type"] = "application/json";
        break;
      case TipoCabecalho.multparte:
        headers["Content-Type"] = "multipart/form-data";
        if (token.isNotEmpty) {
          headers["Authorization"] = "Bearer $token";
        }
        break;
      case TipoCabecalho.requisicao:
        headers["Content-Type"] = "application/json";
        if (token.isNotEmpty) {
          headers["Authorization"] = "Bearer $token";
        }
        break;
    }

    return Options(headers: headers);
  }
}
