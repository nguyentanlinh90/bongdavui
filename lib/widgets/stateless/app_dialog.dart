import 'package:bongdavui/config/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String content;
  final String no;
  final String yes;
  final VoidCallback? noCallback;
  final VoidCallback? yesCallback;

  AppDialog(
      {required this.title,
      required this.content,
      this.no = '',
      required this.yes,
      this.noCallback,
      this.yesCallback});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Text(
        title,
        softWrap: true,
        style: AppTextStyles.h4(),
      ),
      content: Text(
        content,
        style: AppTextStyles.h5(),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: AppColors.white),
          child: Text(
            no,
            style: AppTextStyles.h5().copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: AppColors.white),
          child: Text(
            yes,
            style: AppTextStyles.h5().copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
