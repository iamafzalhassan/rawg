import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class AppFont {
  static TextStyle style({
    double fontSize = 14,
    Color color = AppPalette.white,
    FontWeight fontWeight = FontWeight.normal,
    double? height = 1.25,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontFamily: 'SFProDisplay',
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }
}