import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppPalette.white,
        content: Text(content, style: AppFont.style(color: AppPalette.black, fontSize: 16)),
        duration: const Duration(seconds: 2),
      ),
    );
}