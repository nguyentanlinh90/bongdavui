import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/app_strings.dart';

class ForgotPass extends StatelessWidget {
  final VoidCallback onPress;
  const ForgotPass({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        style: TextButton.styleFrom(primary: AppColors.white),
        onPressed: onPress,
        child: Text(AppString.forgotPassword,
            style: AppTextStyles.h5().copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
                height: 0.1)),
      ),
    );
  }
}
