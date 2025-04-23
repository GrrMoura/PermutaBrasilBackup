import 'package:permuta_brasil/models/contato_model.dart';
import 'package:permuta_brasil/models/foto_model.dart';

class PropagandaViewModel {
  int? propagandaId;
  String? titulo;
  String? resumo;
  String? instagram;
  List<FotoModel>? fotoModel;
  List<ContatoModel>? contatos;

  PropagandaViewModel(
      {this.titulo,
      this.resumo,
      this.instagram,
      this.contatos,
      this.fotoModel,
      this.propagandaId});

  Map<String, dynamic> toJson() {
    return {
      'Titulo': titulo,
      'Resumo': resumo,
      'Instagram': instagram,
      'Fotos': fotoModel?.map((foto) => foto.toJson()).toList(),
      'Contatos': contatos?.map((contato) => contato.toJson()).toList(),
    };
  }

  factory PropagandaViewModel.fromJson(Map<String, dynamic> map) {
    return PropagandaViewModel(
      titulo: map['Titulo'],
      resumo: map['Resumo'],
      instagram: map['Instagram'],
      propagandaId: map['PropagandaId'],
      contatos: map['Contatos'] != null
          ? List<ContatoModel>.from(
              map['Contatos'].map((contato) => ContatoModel.fromJson(contato)))
          : [],
      fotoModel: map['Fotos'] != null
          ? List<FotoModel>.from(
              map['Fotos'].map((foto) => FotoModel.fromJson(foto)))
          : [],
    );
  }
}
