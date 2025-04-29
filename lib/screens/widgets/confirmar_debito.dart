import 'package:flutter/material.dart';
import 'package:permutabrasil/utils/app_colors.dart';

class ConfirmarDebitoDialog {
  static Future<bool?> mostrar(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Column(
            children: [
              Icon(
                Icons.info_outline,
                size: 50,
                color: Colors.teal, // Ícone teal
              ),
              SizedBox(height: 12),
              Text(
                'Confirmação Necessária',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.sBlue, // Título azul
                ),
              ),
            ],
          ),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Essa ação irá debitar créditos da sua conta.\nDeseja continuar?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Botão Cancelar azul
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Botão Confirmar teal
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }
}
