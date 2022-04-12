import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../main/main_page.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      borderRadius: BorderRadius.circular(AppSizes.s_24),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MainPage()));
        },
        splashColor: Colors.black38,
        borderRadius: BorderRadius.circular(AppSizes.s_24),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s_50, vertical: AppSizes.s_5),
          child: Text(
            AppString.skip,
            style:
            AppTextStyles.h5().copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
