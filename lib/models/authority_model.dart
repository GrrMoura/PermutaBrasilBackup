class AuthorityModel {
  String authority;

  AuthorityModel({required this.authority});

  factory AuthorityModel.fromJson(Map<String, dynamic> json) {
    return AuthorityModel(authority: json['authority'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'authority': authority};
  }

  static List<AuthorityModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AuthorityModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<AuthorityModel> authorities) {
    return authorities.map((authority) => authority.toJson()).toList();
  }
}
