class RecuperarSenhaModel {
  String? email;

  RecuperarSenhaModel({this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory RecuperarSenhaModel.fromJson(Map<String, dynamic> json) {
    return RecuperarSenhaModel(
      email: json['email'],
    );
  }
}
