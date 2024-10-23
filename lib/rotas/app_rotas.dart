import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/screens/cadastrar_screen.dart';
import 'package:permuta_brasil/screens/home_controller.dart';
import 'package:permuta_brasil/screens/login_screen.dart';
import 'package:permuta_brasil/screens/recuperar_senha_screen.dart';
import 'package:permuta_brasil/screens/selecao_estados_screen.dart';

class Rotas {
  Rotas();
  static final routers = GoRouter(
    initialLocation: AppRouterName.selecaoEstado,
    routes: [
      GoRoute(
        path: AppRouterName.cadastro,
        builder: (context, state) => (const CadastroScreen()),
      ),
      GoRoute(
        path: AppRouterName.recuperarSenha,
        builder: (context, state) => (const RecuperarSenhaScreen()),
      ),
      GoRoute(
        path: AppRouterName.login,
        builder: (context, state) => (const LoginScreen()),
      ),
      GoRoute(
        path: AppRouterName.home,
        builder: (context, state) => (const HomeControler()),
      ),
      GoRoute(
        path: AppRouterName.selecaoEstado,
        builder: (context, state) => (const SelecaoEstadosScreen()),
      ),
    ],
  );
}
