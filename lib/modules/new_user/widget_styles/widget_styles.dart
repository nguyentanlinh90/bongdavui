import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';

class WidgetStyles {
  static ButtonStyle styleButtonLogin(Color backgroundColor) {
    return ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        primary: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s_8)));
  }
}
