import 'dart:developer' as developer;

class ApiServices {
  //produção
  static const String intranetUrl = "";

  static const String apiUrl = "https://permutabrasil-backend.dev.79team.com/";

  static String concatApiUrl(String url) {
    developer.log("", name: "Serviço de API");

    return apiUrl + url;
  }
}
