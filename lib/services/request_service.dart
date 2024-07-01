import 'package:dio/dio.dart';

class RequestService {
  static int tempoLimite = 80; // em segundos
  final Dio _dio;

  RequestService(this._dio);

  Future<Response> post(String url, {dynamic data}) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      throw Exception('Erro ao fazer requisição POST: $e');
    }
  }

  static Future<Response> postOptions(
      {required String url,
      Map<String, dynamic>? data,
      required Options options}) async {
    try {
      Dio dio = Dio(BaseOptions(
          connectTimeout: Duration(seconds: tempoLimite),
          receiveTimeout: Duration(seconds: tempoLimite)));
      Response response = await dio.post(url, data: data, options: options);

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          Response response = Response(
              statusCode: 504,
              requestOptions: RequestOptions(path: ''),
              statusMessage:
                  "Tempo para tentativa de conexão excedido, caso o erro persista entre em contato com a DTI");

          return response;
        } else {
          Response response = Response(
              statusCode: 403,
              requestOptions: RequestOptions(path: ''),
              statusMessage:
                  "Não foi possível estabelecer conexão com o servidor.");

          return response;
        }
      }
    }
  }

  // Outros métodos HTTP (GET, PUT, DELETE) podem ser adicionados aqui conforme necessário
}
