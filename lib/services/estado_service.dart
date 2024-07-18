import 'package:dio/dio.dart';
import 'package:permuta_brasil/services/api_service.dart';
import 'package:permuta_brasil/services/request_service.dart';

class EstadoService {
  static Future<Response> getEstados() async {
    var url = ApiServices.concatApiUrl("estado");

    var options = Options(headers: {});

    var response = await RequestService.getOptions(url: url, options: options);

    return response;
  }
}
