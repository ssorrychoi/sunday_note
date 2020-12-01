import 'package:flutter/material.dart';

class CustomTextTheme extends TextTheme {
  static TextStyle get notoSansBold1 => const TextStyle(
        fontFamily: 'NotoSans',
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: textBlackColor,
      );

  static TextStyle get notoSansRegular1 => const TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 24,
      color: textBlackColor,
      fontWeight: FontWeight.normal);
}

/// 색상 지정
const backgroundColor = const Color(0xFFF5F5F5);
const topBgColor = const Color(0xFFD6E8FF);
const textBlackColor = const Color(0xFF222222);
