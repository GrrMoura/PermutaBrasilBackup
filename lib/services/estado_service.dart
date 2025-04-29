import 'package:dio/dio.dart';
import 'package:permutabrasil/services/api_service.dart';
import 'package:permutabrasil/services/request_service.dart';

class EstadoService {
  static Future<Response> getEstados() async {
    var url = ApiServices.concatApiUrl("publico/cadastrar");

    var options = Options(headers: {});

    var response = await RequestService.getOptions(url: url, options: options);

    return response;
  }
}
