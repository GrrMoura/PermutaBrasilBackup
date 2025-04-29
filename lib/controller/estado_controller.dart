// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:permutabrasil/models/estado_instituicoes_model.dart';
import 'package:permutabrasil/models/estado_model.dart';
import 'package:permutabrasil/models/instituicao_model.dart';
import 'package:permutabrasil/services/estado_service.dart';
import 'package:permutabrasil/services/dispositivo_service.dart';
import 'package:permutabrasil/utils/erro_handler.dart';

class EstadoController {
  static Future<EstadosEInstituicoes> getEstados(BuildContext context) async {
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return EstadosEInstituicoes(estados: [], instituicoes: []);
    }

    Response response = await EstadoService.getEstados();

    if (response.statusCode != 200) {
      ErroHandler.tratarErro(context, response);
      return EstadosEInstituicoes(estados: [], instituicoes: []);
    }

    List<EstadoModel> estados =
        EstadoModel.fromJsonList(response.data['estados']);
    List<InstituicaoModel> instituicoes =
        InstituicaoModel.fromJsonList(response.data['instituicoes']);

    return EstadosEInstituicoes(estados: estados, instituicoes: instituicoes);
  }
}
