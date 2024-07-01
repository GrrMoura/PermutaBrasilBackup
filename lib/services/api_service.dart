import 'dart:developer' as developer;

class ApiServices {
  //produção
  static const String intranetUrl = "";

  static const String suporteDti = "";

  static String concatIntranetUrl(String url) {
    developer.log("", name: "Serviço de API");

    return intranetUrl + url;
  }

  static String concatPUrl(String url) => suporteDti + url;
}
