import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/widgets/stateless/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_sizes.dart';
import 'custom_text.dart';

SafeArea deviceScreen({required Widget child}) {
  return SafeArea(
    top: false,
    bottom: Device.get().isIphoneX ? true : false,
    child: child,
  );
}

Widget screenWithKeyboard(BuildContext context, Widget widget) {
  return GestureDetector(
    onTap: () {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child: widget,
  );
}

AppBar baseAppBar(BuildContext context, String title) {
  return AppBar(
    title: textTitle(title),
    centerTitle: true,
    leading:  buttonBack(context),
    backgroundColor: AppColors.primaryColor,
    bottomOpacity: 0.0,
    elevation: 0.0,
  );
}
Widget buttonBack(BuildContext context) {
  return   InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
        alignment: Alignment.center,
        child: const FaIcon(
          FontAwesomeIcons.angleLeft,
          size: AppSizes.s_30,
        )),
  );
}

AppBar appBarWithoutBackButton(BuildContext context, String title) {
  return AppBar(
    title: textTitle(title),
    centerTitle: true,
    backgroundColor: AppColors.white,
    bottomOpacity: 0.0,
    elevation: 0.0,
  );
}

Widget loadingCenter() {
  return Container(
    color: Colors.white.withOpacity(0.5),
    child: const Center(
      child: CircularProgressIndicator(strokeWidth: 2
          // valueColor: AlwaysStoppedAnimation<Color>(AppColor.red),
          ),
    ),
  );
}

Widget loadingCenterSmall() {
  return const Center(
    // heightFactor: 1,
    // widthFactor: 1,
    child: SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
      ),
    ),
  );
}

Widget loadMore({required bool loading}) {
  return loading
      ? Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            width: 40,
            height: 40,
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Center(child: CircularProgressIndicator())),
          ),
        )
      : const SizedBox(
          width: 0,
          height: 0,
        );
}

BoxDecoration bgIconHome(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: color,
  );
}

BoxDecoration bgRadius(Color color, double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: color,
  );
}

BoxDecoration bgWithOpacity() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.black12.withOpacity(0.2),
  );
}

SizedBox spaceHeight(double space) {
  return SizedBox(
    height: space,
  );
}

SizedBox spaceWidth(double space) {
  return SizedBox(
    width: space,
  );
}

BoxDecoration bgShadow(Color color, double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: color,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 0.5,
        offset: Offset(1, 1),
      ),
    ],
  );
}

BoxDecoration bgBorder(Color color, Color border, double radius) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      border: Border.all(color: border));
}

BoxDecoration bgBorderSmall(Color color, Color border, double radius) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      border: Border.all(color: border, width: 0.5));
}

BoxDecoration bgCircle(Color color) {
  return BoxDecoration(color: color, shape: BoxShape.circle);
}

BoxDecoration bgCircleBorder(Color color, Color border) {
  return BoxDecoration(
      color: color, shape: BoxShape.circle, border: Border.all(color: border));
}

Widget buttonSubmit(String title, VoidCallback onSubmit) {
  return InkWell(
    child: Container(
      decoration: bgRadius(AppColors.primaryColor, 12),
      padding: EdgeInsets.only(
          top: Device.get().isPhone ? 12 : 14,
          bottom: Device.get().isPhone ? 12 : 14),
      child: Center(child: textWhiteLargeBold(title.toUpperCase())),
    ),
    onTap: onSubmit,
  );
}
