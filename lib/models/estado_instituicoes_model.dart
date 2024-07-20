import 'package:permuta_brasil/models/estado_model.dart';
import 'package:permuta_brasil/models/instituicao_model.dart';

class EstadosEInstituicoes {
  final List<EstadoModel> estados;
  final List<InstituicaoModel> instituicoes;

  EstadosEInstituicoes({
    required this.estados,
    required this.instituicoes,
  });
}
