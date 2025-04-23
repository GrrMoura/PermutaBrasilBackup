class ContatoModel {
  String? telefone;
  String? email;
  String? site;

  ContatoModel({
    this.telefone,
    this.email,
    this.site,
  });

  Map<String, dynamic> toJson() {
    return {
      'Telefone': telefone,
      'Email': email,
      'Site': site,
    };
  }

  factory ContatoModel.fromJson(Map<String, dynamic> json) {
    return ContatoModel(
      telefone: json['Telefone'] ?? '',
      email: json['Email'] ?? '',
      site: json['Site'] ?? '',
    );
  }
}
