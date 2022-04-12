import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle thin(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w100));
  }

  static TextStyle extraLight(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w200));
  }

  static TextStyle light(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w300));
  }

  static TextStyle regular(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w400));
  }

  static TextStyle medium(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w500));
  }

  static TextStyle semiBold(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w600));
  }

  static TextStyle bold(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w700));
  }

  static TextStyle extraBold(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w800));
  }

  static TextStyle black(double size) {
    return GoogleFonts.sen(
        textStyle: TextStyle(fontSize: size, fontWeight: FontWeight.w900));
  }

  static TextStyle h1() {
    return GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 109.66));
  }

  static TextStyle h2() {
    return GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 67.77));
  }

  static TextStyle h3() {
    return GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 41.89));
  }

  static TextStyle h4() {
    return GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 25.89));
  }

  static TextStyle h5() {
    return GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 16));
  }

  static TextStyle h6() {
    return GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 9.89));
  }
}
