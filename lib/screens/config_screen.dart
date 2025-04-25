import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permuta_brasil/screens/widgets/app_bar.dart';
import 'package:permuta_brasil/utils/app_colors.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool isVisible = true;
  bool isNotificationEnable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const CustomAppBar(titulo: "Configurações"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: ListView(
          children: [
            SizedBox(height: 9.h),
            _buildPlanoCard(context),
            SizedBox(height: 9.h),
            _buildConfigPessoal(),
            SizedBox(height: 9.h),
            _buildVisibilityCard(context),
            SizedBox(height: 9.h),
            _buildSuportCard(),
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

            Row(
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
            SizedBox(height: 10.h),

            Row(
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
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.lock,
                  size: 22.sp,
                  color: Colors.grey[700],
                ),
                SizedBox(width: 8.w),
                Text(
                  'Alterar Senha',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSuportCard() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12.0)),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Suporte',
              style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold)),
          SizedBox(height: 6.h),
          ListTile(
            minLeadingWidth: 30.w,
            minTileHeight: 35.h,
            leading: const Icon(Icons.help_outline),
            title: const Text('Como usar o app'),
            onTap: () async {
              // Ação ao clicar na opção
            },
          ),
          ListTile(
            minLeadingWidth: 30.w,
            minTileHeight: 35.h,
            leading: const Icon(Icons.contact_support),
            title: const Text('Contato para Suporte'),
            onTap: () {
              // Ação ao clicar na opção
            },
          ),
        ],
      ),
    );
  }

  Card _buildVisibilityCard(BuildContext context) {
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
                  'Controle de Visibilidade e Notificações',
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
                      setState(() {
                        isVisible = value;
                      });
                    },
                    activeColor: AppColors.cAccentColor,
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
                    Icon(Icons.notifications, color: Colors.grey[700]),
                    SizedBox(width: 8.w),
                    Text(
                      'Receber Notificações',
                      style:
                          TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isNotificationEnable,
                    onChanged: (bool value) {
                      setState(() {
                        isNotificationEnable = value;
                      });
                    },
                    activeColor: AppColors.cAccentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card _buildPlanoCard(BuildContext context) {
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
                  'Detalhes do Plano',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.workspace_premium,
                          color: Color(0xFFFFD700)),
                      SizedBox(width: 6.w),
                      Text(
                        'Plano: Ouro',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money, color: Color(0xFFFFD700)),
                      SizedBox(width: 6.w),
                      Text(
                        'R\$ 100,00',
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.credit_score, color: Colors.green),
                    SizedBox(width: 6.w),
                    Text(
                      'Créditos: 18',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.verified, color: Colors.blue),
                    SizedBox(width: 6.w),
                    Text(
                      'Status: Ativo',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.grey),
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
