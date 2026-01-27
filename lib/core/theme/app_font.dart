import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class AppFont {
  static TextStyle style({
    double fontSize = 14,
    double? height = 1.25,
    Color color = AppPalette.white,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.normal,
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