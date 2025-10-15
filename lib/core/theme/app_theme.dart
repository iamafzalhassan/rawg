import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';

import 'app_pallete.dart';

class AppTheme {
  static final darkMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppPalette.black2),
    elevatedButtonTheme: elevatedButtonTheme(),
    outlinedButtonTheme: outLinedButtonTheme(),
    scaffoldBackgroundColor: AppPalette.black2,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPalette.white,
      circularTrackColor: AppPalette.gray4,
    ),
  );

  static elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.gray6,
        elevation: 0,
        overlayColor: AppPalette.gray1,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

  static outLinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        overlayColor: AppPalette.gray1,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        side: const BorderSide(color: AppPalette.gray6, width: 4),
        textStyle: AppFont.style(color: AppPalette.white, fontSize: 20.0),
      ),
    );
  }
}