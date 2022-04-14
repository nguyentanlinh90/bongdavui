import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../config/theme/app_colors.dart';

class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget widget;

  const AppLoadingOverlay(
      {Key? key, required this.isLoading, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: AppColors.primaryColor,
      progressIndicator: const CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
      child: widget,
    );
  }
}
