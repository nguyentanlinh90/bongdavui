
import 'package:flutter/material.dart';

import '../config/theme/app_colors.dart';
Text textTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
        //fontFamily: 'Mulish-Bold',
        fontSize: 18,
        color: AppColors.white,
        fontWeight: FontWeight.bold),
  );
}

// TODO text app default
Text text(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.primaryColor,
    //  fontFamily: 'Mulish',
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

Text textBold(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.primaryColor,
     // fontFamily: 'Mulish-Bold',
      fontSize: 13,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text textLarge(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.primaryColor,
     // fontFamily: 'Mulish',
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
  );
}
Text textLargeBold(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.primaryColor,
    //  fontFamily: 'Mulish-Bold',
      fontSize: 15,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text textXLarge(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.primaryColor,
      //fontFamily: 'Mulish',
      fontSize: 17,
      fontWeight: FontWeight.normal,
    ),
  );
}

// TODO text White
Text textWhite(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.white,
      //fontFamily: 'Mulish',
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}
Text textWhiteLarge(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.white,
    //  fontFamily: 'Mulish',
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
  );
}
Text textWhiteLargeBold(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.white,
     // fontFamily: 'Mulish-Bold',
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );
}
Text textWhiteBold(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.white,
     // fontFamily: 'Mulish-Bold',
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),
  );
}
Text textWhiteSmall(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: AppColors.white,
      //fontFamily: 'Mulish',
      fontSize: 11,
      fontWeight: FontWeight.normal,
    ),
  );
}

// todo custom other







