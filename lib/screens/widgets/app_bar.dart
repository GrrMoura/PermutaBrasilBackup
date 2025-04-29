import 'package:flutter/material.dart';
import 'package:permutabrasil/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const CustomAppBar({super.key, required this.titulo});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: AppColors.cAccentColor,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
