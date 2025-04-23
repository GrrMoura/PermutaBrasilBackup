import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';

class DispositivoService {
  static Future<bool> verificarConexao() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
  }

  static Future<bool> verificarConexaoComFeedback(BuildContext context) async {
    bool conectado = await verificarConexao();

    if (!conectado) {
      Generic.snackBar(
        // ignore: use_build_context_synchronously
        context: context,
        mensagem: "Sem conexão com a internet.",
      );
    }

    return conectado;
  }
}
