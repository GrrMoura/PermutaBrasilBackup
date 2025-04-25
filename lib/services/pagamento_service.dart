import 'package:dio/dio.dart';
import 'package:permuta_brasil/services/api_service.dart';
import 'package:permuta_brasil/services/autenticacao_service.dart';
import 'package:permuta_brasil/services/request_service.dart';
import 'package:permuta_brasil/utils/enums/enums.dart';

class PagamentoService {
  static Future<Response> buyCredits(int? idUsuario, int? idPlano) async {
    var url = ApiServices.concatApiUrl("credito/comprar");

    var options =
        await AutenticacaoService.getCabecalho(TipoCabecalho.requisicao);

    var response = await RequestService.postOptions(
        url: url,
        data: {"idUsuario": idUsuario, "idPlano": idPlano},
        options: options);

    return response;
  }
}
