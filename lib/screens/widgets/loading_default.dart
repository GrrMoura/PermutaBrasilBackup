import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/styles.dart';

class LoadingDefault extends StatelessWidget {
  // final bool _visible = true;
  const LoadingDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cPrimaryColor,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SpinKitSpinningLines(
                color: AppColors.sBlue,
                size: 120,
                duration: Duration(milliseconds: 1500)),
            SizedBox(height: 30.h),
            Text(
              "Aguarde! Carregando informações...",
              style: Styles().mediumTextStyle(),
            )
          ]),
        ),
      ),
    );
  }
}

class LoadingPequenoDefault extends StatelessWidget {
  final double? tamanho;
  final Color? cor;
  const LoadingPequenoDefault({super.key, this.tamanho, this.cor});

  @override
  Widget build(BuildContext context) {
    return SpinKitHourGlass(
        color: cor ?? AppColors.cAccentColor,
        size: tamanho ?? 100,
        duration: const Duration(seconds: 1));
  }
}

class LoadingHourGlass extends StatelessWidget {
  final double? tamanho;
  final Color? cor;
  const LoadingHourGlass({super.key, this.tamanho, this.cor});

  @override
  Widget build(BuildContext context) {
    return SpinKitHourGlass(
        color: cor ?? AppColors.cAccentColor,
        size: tamanho ?? 100,
        duration: const Duration(seconds: 2));
  }
}

class LoadingDualRing extends StatelessWidget {
  final double? tamanho;
  final Color? cor;
  const LoadingDualRing({super.key, this.tamanho, this.cor});

  @override
  Widget build(BuildContext context) {
    return SpinKitDualRing(
        lineWidth: 3,
        color: cor ?? AppColors.cAccentColor,
        size: tamanho ?? 100,
        duration: const Duration(milliseconds: 1000));
  }
}
