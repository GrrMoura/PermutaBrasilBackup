import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permutabrasil/utils/app_colors.dart';

class SelecionarImagemDialog {
  static Future<ImageSource?> mostrar(BuildContext context) {
    return showDialog<ImageSource>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Column(
            children: [
              SizedBox(height: 12),
              Text(
                'Selecionar Imagem',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.sBlue,
                ),
              ),
            ],
          ),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Escolha de onde deseja obter a imagem:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: const Text('Tirar Foto'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: const Text('Galeria'),
            ),
          ],
        );
      },
    );
  }
}
