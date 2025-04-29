import 'package:dio/dio.dart';
import 'package:permutabrasil/services/api_service.dart';
import 'package:permutabrasil/services/autenticacao_service.dart';
import 'package:permutabrasil/services/request_service.dart';
import 'package:permutabrasil/utils/enums/enums.dart';

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
