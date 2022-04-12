import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';

class OrLine extends StatelessWidget {
  const OrLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: AppColors.blackGrey,
            height: 1,
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(right: AppSizes.s_10, left: AppSizes.s_10),
          child: Text(
            AppString.or,
            style: AppTextStyles.black(AppSizes.s_20)
                .copyWith(color: AppColors.blackGrey),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.blackGrey,
            height: 1,
          ),
        )
      ],
    );
  }
}
