class FotoModel {
  int? fotoId;
  String? nome;
  String? url;
  String? path;
  AcaoFoto? acao;
  int? idPrestador;

  FotoModel(
      {this.url,
      this.idPrestador,
      this.nome,
      this.acao,
      this.fotoId,
      this.path});

  factory FotoModel.fromJson(Map<String, dynamic> json) {
    return FotoModel(
      fotoId: json['FotoId'],
      url: json['FotoUrl'],
      nome: json['NomeArquivo'],
      idPrestador: json['PrestadorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FotoId': fotoId,
      'PrestadorId': idPrestador,
      'NomeArquivo': nome,
      'AcaoFoto': acao.toString().split('.').last,
      'Path': path,
      'FotoUrl': url
    };
  }

  Map<String, dynamic> toData() {
    return {
      'PrestadorId': idPrestador,
      'NomeArquivo': nome,
      'FotoId': fotoId,
      'FotoUrl': url
    };
  }
}

enum AcaoFoto {
  adicionar,
  atualizar,
  remover,
}
