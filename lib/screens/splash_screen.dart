// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permutabrasil/rotas/app_screens_path.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashTermosPage extends StatefulWidget {
  const SplashTermosPage({super.key});

  @override
  State<SplashTermosPage> createState() => _SplashTermosPageState();
}

class _SplashTermosPageState extends State<SplashTermosPage> {
  @override
  void initState() {
    super.initState();
    _checkAceiteTermos();
  }

  Future<void> _checkAceiteTermos() async {
    final prefs = await SharedPreferences.getInstance();

    final aceitou = prefs.getBool('aceitou_termos') ?? false;

    if (aceitou) {
      context.go(AppRouterName.login);
    } else {
      context.go(AppRouterName.termoScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingDualRing(),
      ),
    );
  }
}
