import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permutabrasil/controller/user_controller.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/screens/widgets/app_bar.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/utils/app_colors.dart';
import 'package:permutabrasil/viewModel/pagamento_view_model.dart';

class HistoricoComprasScreen extends ConsumerStatefulWidget {
  const HistoricoComprasScreen({super.key});

  @override
  ConsumerState<HistoricoComprasScreen> createState() =>
      _HistoricoComprasScreenState();
}

class _HistoricoComprasScreenState
    extends ConsumerState<HistoricoComprasScreen> {
  List<PagamentoViewModel> pagamentos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pegarPagamentos();
  }

  void _pegarPagamentos() async {
    final resultado = await UserController.buscarPagamentos(context);

    if (mounted && resultado != null) {
      final apenasAprovados = resultado
          .where((p) => p.statusFormatado.toLowerCase() == 'pago')
          .toList();

      setState(() {
        pagamentos = apenasAprovados;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final creditos = ref.watch(creditoProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const CustomAppBar(titulo: "Histórico de Compras"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.shopping_cart_checkout,
                            color: Colors.green[600], size: 36.sp),
                        SizedBox(height: 4.h),
                        Text(
                          'Saldo atual',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          '$creditos créditos',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoadingDualRing(tamanho: 50.sp),
                    )
                  else
                    ..._buildHistoricoComprasWidgets(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHistoricoComprasWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < pagamentos.length; i++) {
      final pagamento = pagamentos[i];

      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.add_circle_outline,
                color: Colors.green[600],
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '+${(pagamento.valorSolicitadoCents / 100).toStringAsFixed(0)} créditos',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Plano: ${pagamento.plano.nome}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${pagamento.dataHoraCriacao.day.toString().padLeft(2, '0')}/'
                          '${pagamento.dataHoraCriacao.month.toString().padLeft(2, '0')}/'
                          '${pagamento.dataHoraCriacao.year}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      if (i != pagamentos.length - 1) {
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1.5,
                    color: Colors.grey[300],
                    endIndent: 8.w,
                  ),
                ),
                Icon(Icons.fiber_manual_record,
                    color: Colors.green[600]!.withOpacity(0.8), size: 18.sp),
                Expanded(
                  child: Divider(
                    thickness: 1.5,
                    color: Colors.grey[300],
                    indent: 8.w,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    if (pagamentos.isEmpty) {
      widgets.add(
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              'Nenhuma compra registrada.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}
