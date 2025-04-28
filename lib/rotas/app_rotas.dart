import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/models/plano_model.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/screens/cadastro/cadastrar_screen.dart';
import 'package:permuta_brasil/screens/home_controller.dart';
import 'package:permuta_brasil/screens/login_screen.dart';
import 'package:permuta_brasil/screens/home_screen.dart';
import 'package:permuta_brasil/screens/pagamento/pagamento_pix.dart';
import 'package:permuta_brasil/screens/pagamento/planos_screen.dart';
import 'package:permuta_brasil/screens/recuperar_senha_screen.dart';
import 'package:permuta_brasil/screens/cadastro/selecao_estados_screen.dart';

class Rotas {
  Rotas();
  static final routers = GoRouter(
    initialLocation: AppRouterName.login,
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
        path: AppRouterName.planoScreen,
        builder: (context, state) => (const PlanoScreen()),
      ),
      GoRoute(
        path: AppRouterName.login,
        builder: (context, state) => (const LoginScreen()),
      ),
      GoRoute(
        name: 'pagamentoPixScreen',
        path: AppRouterName.pagamentoPixScreen,
        builder: (context, state) {
          PlanoModel model = state.extra as PlanoModel;
          return (PagamentoPix(
            planoModel: model,
          ));
        },
      ),
      GoRoute(
        path: AppRouterName.homeScreen,
        builder: (context, state) {
          return (const HomeScreen());
        },
      ),
      GoRoute(
        path: AppRouterName.homeController,
        builder: (context, state) => (const HomeControler()),
      ),
      GoRoute(
        path: AppRouterName.selecaoEstado,
        builder: (context, state) => (const SelecaoEstadosScreen()),
      ),
    ],
  );
}
