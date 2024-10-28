import 'package:permuta_brasil/models/estado_model.dart';
import 'package:permuta_brasil/models/profissional_model.dart';

class MatchModel {
  EstadoModel estado;
  ProfissionalModel profissional;

  MatchModel({
    required this.estado,
    required this.profissional,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      estado: EstadoModel.fromJson(json['estado']),
      profissional: ProfissionalModel.fromJson(json['profissional']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado.toJson(),
      'profissional': profissional.toJson(),
    };
  }
}
