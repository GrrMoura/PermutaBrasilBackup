import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/screens/cadastrar_screen.dart';
import 'package:permuta_brasil/screens/home_controller.dart';
import 'package:permuta_brasil/screens/login_screen.dart';
import 'package:permuta_brasil/screens/macth_screen.dart';
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
        path: AppRouterName.matchScreen,
        builder: (context, state) {
          return (const MatchsScreen(
            nomeUsuario: "Roberto Rocha",
            matchs: [
              {
                "nome": "Maria Silva",
                "estado": "SP",
                "telefone": "(11) 98765-4321",
                "imagem": "assets/images/saopaulo.png",
              },
              {
                "nome": "Carlos Souza",
                "estado": "RJ",
                "telefone": "(21) 91234-5678",
                "imagem": "assets/images/riodejaneiro.png",
              },
              {
                "nome": "Ana Costa",
                "estado": "MG",
                "telefone": "(31) 99876-5432",
                "imagem": "assets/images/minasgerais.png",
              },
            ],
          ));
        },
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
