import 'package:go_router/go_router.dart';
import 'package:permutabrasil/models/estado_model.dart';
import 'package:permutabrasil/models/plano_model.dart';
import 'package:permutabrasil/rotas/app_screens_path.dart';
import 'package:permutabrasil/screens/cadastro/cadastrar_screen.dart';
import 'package:permutabrasil/screens/cadastro/termos_screen.dart';
import 'package:permutabrasil/screens/configuracoes/alterar_dados_pessoais.dart';
import 'package:permutabrasil/screens/configuracoes/alterar_estados.dart';
import 'package:permutabrasil/screens/configuracoes/historico_de_compras.dart';
import 'package:permutabrasil/screens/configuracoes/historico_gasto.dart';
import 'package:permutabrasil/screens/home_controller.dart';
import 'package:permutabrasil/screens/login_screen.dart';
import 'package:permutabrasil/screens/home_screen.dart';
import 'package:permutabrasil/screens/pagamento/pagamento_pix.dart';
import 'package:permutabrasil/screens/pagamento/planos_screen.dart';
import 'package:permutabrasil/screens/esqueceu_senha_screen.dart';
import 'package:permutabrasil/screens/configuracoes/redefinir_senha_screen.dart';
import 'package:permutabrasil/screens/splash_screen.dart';
import 'package:permutabrasil/viewModel/profissional_view_model.dart';

class Rotas {
  Rotas();
  static final routers = GoRouter(
    initialLocation: AppRouterName.splashScreen,
    routes: [
      GoRoute(
        path: AppRouterName.cadastro,
        builder: (context, state) => (const CadastroScreen()),
      ),
      GoRoute(
        path: AppRouterName.esqueceuSenha,
        builder: (context, state) => (const EsqueceuSenhaScreen()),
      ),
      GoRoute(
        path: AppRouterName.redefinirSenha,
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          final extra = state.extra;
          final modoInterno =
              extra is Map<String, dynamic> && extra['modoInterno'] == true;

          return RedefinirSenhaScreen(
            modoInterno: modoInterno,
            token: token,
          );
        },
      ),
      GoRoute(
        path: AppRouterName.planoScreen,
        builder: (context, state) => (const PlanoScreen()),
      ),
      GoRoute(
        path: AppRouterName.splashScreen,
        builder: (context, state) => (const SplashTermosPage()),
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
          return (PagamentoPix(planoModel: model));
        },
      ),
      GoRoute(
        path: AppRouterName.homeScreen,
        builder: (context, state) {
          return (const HomeScreen());
        },
      ),
      GoRoute(
        path: AppRouterName.termoScreen,
        builder: (context, state) {
          return (const TermosCadastroPage());
        },
      ),
      GoRoute(
        path: AppRouterName.historicoGasto,
        builder: (context, state) {
          return (HistoricoGastosScreen());
        },
      ),
      GoRoute(
        path: AppRouterName.historicoCompra,
        builder: (context, state) {
          return (const HistoricoComprasScreen());
        },
      ),
      GoRoute(
        path: AppRouterName.homeController,
        builder: (context, state) {
          final pagina = (state.extra is int) ? state.extra as int : 1;
          return (HomeControler(
            selectedPage: pagina,
          ));
        },
      ),
      GoRoute(
        path: AppRouterName.selecaoEstado,
        builder: (context, state) {
          return const SelecaoEstadosScreen();
        },
      ),
      GoRoute(
        path: AppRouterName.alterarDados,
        builder: (context, state) {
          return (const AlterarDadosPessoaisScreen());
        },
      ),
    ],
  );
}
