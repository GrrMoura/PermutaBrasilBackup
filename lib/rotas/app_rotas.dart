import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/screens/cadastrar_screen.dart';
import 'package:permuta_brasil/screens/recuperar_senha_screen.dart';

class Rotas {
  Rotas();
  static final routers = GoRouter(
    initialLocation: AppRouterName.cadastro,
    routes: [
      GoRoute(
        path: AppRouterName.cadastro,
        builder: (context, state) => (const CadastroScreen()),
      ),
      GoRoute(
        path: AppRouterName.recuperarSenha,
        builder: (context, state) => (const RecuperarSenhaScreen()),
      ),
    ],
  );
}
