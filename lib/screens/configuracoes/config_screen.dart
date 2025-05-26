import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permutabrasil/controller/user_controller.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/rotas/app_screens_path.dart';
import 'package:permutabrasil/screens/home_controller.dart';
import 'package:permutabrasil/screens/widgets/app_bar.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/utils/app_colors.dart';
import 'package:permutabrasil/viewModel/profissional_view_model.dart';

class ConfigScreen extends ConsumerStatefulWidget {
  const ConfigScreen({super.key});

  @override
  ConsumerState<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends ConsumerState<ConfigScreen> {
  ProfissionalViewModel? profissionalViewModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
    _pegarProfissional();
  }

  void _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version}+${info.buildNumber}';
    });
  }

  void _pegarProfissional() async {
    final resultado = await UserController.buscarProfissional(context, ref);

    if (mounted && resultado != null) {
      setState(() {
        ref.read(profissionalProvider.notifier).state = resultado;
        isLoading = false;
      });
    }
  }

  String _version = '';

  bool isNotificationEnable = true;
  @override
  Widget build(BuildContext context) {
    final creditos = ref.watch(creditoProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const CustomAppBar(titulo: "Configurações"),
      body: isLoading
          ? const LoadingDualRing()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: ListView(
                children: [
                  SizedBox(height: 9.h),
                  _buildPlanoCard(context, creditos),
                  SizedBox(height: 9.h),
                  _buildConfigPessoal(),
                  SizedBox(height: 9.h),
                  _buildVisibilityCard(context),
                  SizedBox(height: 9.h),
                  Center(
                    child: Text(
                      'Versão $_version',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Card _buildConfigPessoal() {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🛠️ Título do card
            Text(
              'Configurações Pessoais',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),

            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                context.push(AppRouterName.alterarDados);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 22.sp,
                    color: Colors.grey[700],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Alterar Dados Pessoais',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                context.push(
                  AppRouterName.selecaoEstado,
                  extra: profissionalViewModel?.destinos,
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 22.sp,
                    color: Colors.grey[700],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Alterar Locais de Interesse',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // InkWell(
            //   splashColor: Colors.transparent,
            //   highlightColor: Colors.transparent,
            //   onTap: () {
            //     context.push(AppRouterName.redefinirSenha,
            //         extra: {"modoInterno": true});
            //   },
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.lock,
            //         size: 22.sp,
            //         color: Colors.grey[700],
            //       ),
            //       SizedBox(width: 8.w),
            //       Text(
            //         'Alterar Senha',
            //         style: TextStyle(fontSize: 14.sp),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Container _buildSuportCard() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.05),
  //             spreadRadius: 1,
  //             blurRadius: 5,
  //             offset: const Offset(0, 3),
  //           ),
  //         ],
  //         borderRadius: BorderRadius.circular(12.0)),
  //     padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Suporte',
  //             style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold)),
  //         SizedBox(height: 6.h),
  //         ListTile(
  //           minLeadingWidth: 30.w,
  //           minTileHeight: 35.h,
  //           leading: const Icon(Icons.help_outline),
  //           title: const Text('Como usar o app'),
  //           onTap: () async {
  //             // Ação ao clicar na opção
  //           },
  //         ),
  //         ListTile(
  //           minLeadingWidth: 30.w,
  //           minTileHeight: 35.h,
  //           leading: const Icon(Icons.contact_support),
  //           title: const Text('Contato para Suporte'),
  //           onTap: () {
  //             // Ação ao clicar na opção
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Card _buildVisibilityCard(BuildContext context) {
    final profissional = ref.watch(profissionalProvider);
    final isVisible = profissional?.visivelMatch ?? false;
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Controle de Visibilidade',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.visibility, color: Colors.grey[700]),
                    SizedBox(width: 8.w),
                    Text(
                      'Permitir ser encontrado',
                      style:
                          TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isVisible,
                    onChanged: (bool value) {
                      UserController.alterarStatusPerfil(context, ref);
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card _buildPlanoCard(BuildContext context, int creditos) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Exibição do plano atual
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detalhes dos Créditos',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                context.push(AppRouterName.historicoGasto);
              },
              child: Row(
                children: [
                  Icon(Icons.trending_down, color: Colors.red[600]),
                  SizedBox(width: 6.w),
                  Text(
                    'Histórico de gastos',
                    style: TextStyle(fontSize: 14.sp, color: Colors.red[800]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                context.push(AppRouterName.historicoCompra);
              },
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.green[600]),
                  SizedBox(width: 6.w),
                  Text(
                    'Histórico de compras',
                    style: TextStyle(fontSize: 14.sp, color: Colors.green[800]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      const Icon(Icons.credit_score, color: Colors.black54),
                      SizedBox(width: 6.w),
                      Text(
                        'Créditos: $creditos',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.black54),
                SizedBox(width: 6.w),
                Text(
                  'Última recarga: 04/02/2025',
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cAccentColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                label: const Text(
                  'Recarregar agora',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                onPressed: () {
                  final homeState =
                      context.findAncestorStateOfType<HomeControlerState>();
                  homeState?.goToPage(2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
