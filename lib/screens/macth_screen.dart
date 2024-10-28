import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permuta_brasil/utils/app_colors.dart';

class MatchsScreen extends StatelessWidget {
  final String nomeUsuario;
  final List<Map<String, String>> matchs;

  const MatchsScreen({
    super.key,
    required this.nomeUsuario,
    required this.matchs,
  });

  @override
  Widget build(BuildContext context) {
    bool isFuncionalVerificada = false;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(child: _buildMatchList()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Bem-vindo, $nomeUsuario",
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: AppColors.cAccentColor,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Text(
        "Matchs:",
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  ListView _buildMatchList() {
    return ListView.builder(
      itemCount: matchs.length,
      itemBuilder: (context, index) {
        final match = matchs[index];
        return _buildMatchCard(match);
      },
    );
  }

  Widget _buildMatchCard(Map<String, String> match) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildStateImage(match['imagem']!),
                SizedBox(width: 10.w),
                _buildMatchInfo(match),
              ],
            ),
            SizedBox(height: 10.h),
            _buildActionButtons(),
            SizedBox(height: 10.h),
            _buildVerificationCheckbox(),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationCheckbox() {
    bool isFuncionalVerificada = false;
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {
            isFuncionalVerificada = value ?? false;
          },
        ),
        Text(
          "Funcional Verificada",
          style: TextStyle(fontSize: 16.sp, color: Colors.teal),
        ),
      ],
    );
  }
}

Widget _buildActionButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ElevatedButton(
        onPressed: () {
          // Lógica ao clicar em "Tenho Interesse"
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        ),
        child: Text(
          "Tenho Interesse",
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          // Lógica ao clicar em "Rejeitar"
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        ),
        child: Text(
          "Rejeitar",
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    ],
  );
}

Widget _buildStateImage(String imagePath) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.asset(
      imagePath,
      height: 50.h,
      width: 50.w,
      fit: BoxFit.cover,
    ),
  );
}

Widget _buildMatchInfo(Map<String, String> match) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMatchName(match['nome']!),
        SizedBox(height: 10.h),
        _buildMatchDetails("Estado: ", match['estado']!),
        SizedBox(height: 5.h),
        _buildMatchDetails("Telefone: ", match['telefone']!),
      ],
    ),
  );
}

Text _buildMatchName(String name) {
  return Text(
    name,
    style: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: Colors.teal,
    ),
  );
}

Text _buildMatchDetails(String label, String value) {
  return Text(
    "$label$value",
    style: TextStyle(
      fontSize: 16.sp,
      color: Colors.grey[700],
    ),
  );
}
