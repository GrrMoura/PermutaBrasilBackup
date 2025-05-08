import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permutabrasil/screens/widgets/app_bar.dart';
import 'package:permutabrasil/utils/app_colors.dart';

class HistoricoGastosScreen extends StatelessWidget {
  final int saldoAtual = 20; // saldo atual do usuário
  final List<Map<String, dynamic>> historico = [
    {
      'data': '07/05/2025',
      'credito': 5,
      'acao': 'Obteve os dados de contato de João Silva',
    },
    {
      'data': '06/05/2025',
      'credito': 1,
      'acao': 'Créditos usados para manter perfil ativo',
    },
    {
      'data': '05/05/2025',
      'credito': 5,
      'acao': 'Obteve os dados de contato de Maria Souza',
    },
  ];

  HistoricoGastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  /// ✅ SALDO ATUAL CENTRALIZADO
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
                          '$saldoAtual créditos',
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

                  /// ✅ HISTÓRICO
                  ..._buildHistoricoWidgets(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔥 FUNÇÃO PARA CONSTRUIR OS HISTÓRICOS + DIVIDER DIFERENCIADO
  List<Widget> _buildHistoricoWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < historico.length; i++) {
      final item = historico[i];

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
                      '-${item['credito']} créditos',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item['acao'],
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
                          item['data'],
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

      /// 🔥 Adiciona SEPARADOR DIFERENCIADO (exceto no último)
      if (i != historico.length - 1) {
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

    /// ✅ Mensagem caso lista esteja vazia
    if (historico.isEmpty) {
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
}
