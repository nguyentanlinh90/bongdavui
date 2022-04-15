import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle style(
      double fontSize, Color color, FontWeight fontWeight) {
    return GoogleFonts.rubik(textStyle: TextStyle(fontSize: fontSize))
        .copyWith(color: color, fontWeight: fontWeight);
  }

  static TextStyle h1(
      {Color color = AppColors.primaryColor,
      double fontSize = 109.66,
      FontWeight fontWeight = FontWeight.normal}) {
    return style(fontSize, color, fontWeight);
  }

  static TextStyle h2(
      {Color color = AppColors.primaryColor,
      double fontSize = 67.77,
      FontWeight fontWeight = FontWeight.normal}) {
    return style(fontSize, color, fontWeight);
  }

  static TextStyle h3(
      {Color color = AppColors.primaryColor,
      double fontSize = 41.89,
      FontWeight fontWeight = FontWeight.normal}) {
    return style(fontSize, color, fontWeight);
  }

  static TextStyle h4(
      {Color color = AppColors.primaryColor,
      double fontSize = 25.89,
      FontWeight fontWeight = FontWeight.normal}) {
    return style(fontSize, color, fontWeight);
  }

  static TextStyle h5(
      {Color color = AppColors.primaryColor,
      double fontSize = 16,
      FontWeight fontWeight = FontWeight.normal}) {
    return style(fontSize, color, fontWeight);
  }

  static TextStyle h6(
      {Color color = AppColors.primaryColor,
      double fontSize = 9.89,
      FontWeight fontWeight = FontWeight.normal}) {
    return style(fontSize, color, fontWeight);
  }
}
