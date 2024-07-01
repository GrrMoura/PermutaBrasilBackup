import 'package:flutter/material.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/app_dimens.dart';
import 'package:permuta_brasil/utils/app_fonts.dart';

class Styles {
  Styles();

  TextStyle titulo() {
    return TextStyle(
      fontSize: AppDimens.titleSize,
      fontWeight: FontWeight.bold,
      color: AppColors.cAccentColor,
    );
  }

  TextStyle mediumTextStyle() {
    return TextStyle(
        color: AppColors.cAccentColor, fontSize: AppDimens.largeTextSize);
  }

  TextStyle descriptionStyle() {
    return TextStyle(
        color: AppColors.cTextLightColor,
        fontSize: AppDimens.smallSize,
        fontFamily: AppFonts.robotoRegular,
        fontWeight: FontWeight.w400,
        letterSpacing: AppDimens.letterSpace);
  }

  TextStyle textErrorSmallStyle() {
    return TextStyle(
        color: AppColors.cTextBlackColor,
        fontSize: AppDimens.smallSize,
        fontFamily: AppFonts.robotoRegular,
        fontWeight: FontWeight.bold);
  }

  ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.cAccentColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
