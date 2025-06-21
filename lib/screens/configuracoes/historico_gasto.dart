import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permutabrasil/controller/user_controller.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/screens/widgets/app_bar.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/utils/app_colors.dart';
import 'package:permutabrasil/viewModel/gastos_view_model.dart';

class HistoricoGastosScreen extends ConsumerStatefulWidget {
  const HistoricoGastosScreen({super.key});

  @override
  ConsumerState<HistoricoGastosScreen> createState() =>
      _HistoricoGastosScreenState();
}

class _HistoricoGastosScreenState extends ConsumerState<HistoricoGastosScreen> {
  // saldo atual do usuário
  List<GastosViewModel> pagamentos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pegarGastos();
  }

  void _pegarGastos() async {
    final resultado = await UserController.pegarHistoricoConsumo(context);

    if (mounted && resultado != null) {
      setState(() {
        pagamentos = resultado;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final creditos = ref.watch(creditoProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const CustomAppBar(titulo: "Histórico de Gastos"),
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
                        Icon(Icons.account_balance_wallet,
                            color: AppColors.cAccentColor, size: 36.sp),
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
                    ..._buildHistoricoWidgets(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHistoricoWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < pagamentos.length; i++) {
      final item = pagamentos[i];

      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.monetization_on,
                color: AppColors.cAccentColor,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '-${item.valor.toStringAsFixed(2)} créditos',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.descricao,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatarData(item.dataHora),
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
                    color: AppColors.cAccentColor.withOpacity(0.8),
                    size: 18.sp),
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
              'Nenhum gasto registrado.',
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

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }
}
