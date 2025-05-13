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
      return e.response!;
    }
  }

  static Future<Response> postSemOptions(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      Dio dio = Dio(BaseOptions(
          connectTimeout: Duration(seconds: tempoLimite),
          receiveTimeout: Duration(seconds: tempoLimite)));
      Response response = await dio.post(url, data: data);

      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  static Future<Response> getOptions({
    required String url,
    Options? options,
  }) async {
    try {
      Dio dio = Dio(BaseOptions(
        connectTimeout: Duration(seconds: tempoLimite),
        receiveTimeout: Duration(seconds: tempoLimite),
      ));
      Response response = await dio.get(url, options: options);
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
