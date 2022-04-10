import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/config/theme/app_text_styles.dart';
import 'package:bongdavui/constants/app_constants.dart';
import 'package:bongdavui/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widget_styles/widget_styles.dart';

class ResponsiveButton extends StatelessWidget {
  final String type;
  final String btText;
  final VoidCallback onTap;

  const ResponsiveButton({
    Key? key,
    required this.type,
    required this.btText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: type == AppConstants.typeFacebook
          ? WidgetStyles.styleButtonLogin(AppColors.facebook)
          : WidgetStyles.styleButtonLogin(AppColors.google),
      child: Container(
        height: AppSizes.s_60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s_8),
            border: Border.all(color: Colors.grey, width: 0)),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              margin: const EdgeInsets.only(left: AppSizes.s_20),
              child: FaIcon(
                type == AppConstants.typeFacebook
                    ? FontAwesomeIcons.facebook
                    : FontAwesomeIcons.google,
                color: AppColors.white,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                btText,
                style: AppTextStyles.bold(AppSizes.s_16)
                    .copyWith(color: AppColors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
