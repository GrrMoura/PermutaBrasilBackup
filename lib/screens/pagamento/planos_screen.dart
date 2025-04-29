import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permutabrasil/controller/user_controller.dart';
import 'package:permutabrasil/models/plano_model.dart';
import 'package:permutabrasil/rotas/app_screens_path.dart';
import 'package:permutabrasil/screens/widgets/app_bar.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/utils/app_colors.dart';

class PlanoScreen extends StatefulWidget {
  const PlanoScreen({super.key});
  @override
  State<PlanoScreen> createState() => _PlanoScreenState();
}

class _PlanoScreenState extends State<PlanoScreen> {
  bool isOcupado = true;
  List<PlanoModel> planos = [];

  UserController userCtlr = UserController();
  @override
  void initState() {
    super.initState();
    _buscarPlanos();
  }

  Future<void> _buscarPlanos() async {
    List<PlanoModel>? planosApi = await UserController.pegarPlanos(context);

    setState(() {
      planos = planosApi ?? [];
      isOcupado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const CustomAppBar(
        titulo: "Planos Disponíveis",
      ),
      body: isOcupado
          ? Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: const LoadingDualRing(tamanho: 120)),
              ],
            )
          : planos.isEmpty
              ? _buildSemPlano()
              : Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),
                      Expanded(
                        child: GridView.builder(
                          itemCount: planos.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 16.h,
                            crossAxisSpacing: 16.w,
                            childAspectRatio: 2,
                          ),
                          itemBuilder: (context, index) {
                            final plano = planos[index];
                            return _buildPlanoCard(
                                plano: plano, context: context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSemPlano() {
    return Padding(
      padding: EdgeInsets.only(top: 40.h, left: 12.w, right: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Não conseguimos carregar os planos no momento.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanoCard({
    required PlanoModel plano,
    required BuildContext context,
  }) {
    return InkWell(
        onTap: () async {
          context.push(AppRouterName.pagamentoPixScreen, extra: plano);
        },
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32),
            borderRadius: BorderRadius.circular(20.r),
            gradient: PlanoCores.getGradient(plano.nome),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(38),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'R\$ ${plano.valor ?? 0}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Plano ${plano.nome ?? ""}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.8,
                      shadows: const [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black26,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(76),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          plano.descricao ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ],
          ),
        ));
  }
}

class PlanoCores {
  static LinearGradient getGradient(String? nome) {
    switch (nome?.toLowerCase()) {
      case 'ouro':
        return const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFDAA520)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'prata':
        return const LinearGradient(
          colors: [Color(0xFFC0C0C0), Color(0xFF808080)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'bronze':
        return const LinearGradient(
          colors: [Color(0xFFCD7F32), Color(0xFF8B4513)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF388E3C)], // padrão
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
