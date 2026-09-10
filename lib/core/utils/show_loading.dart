import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class ShowLoading {
  static bool isVisible = false;

  static void hide(BuildContext context) {
    if (!isVisible) return;

    isVisible = false;

    Navigator.of(context, rootNavigator: false).pop();
  }

  static void show(BuildContext context) {
    if (isVisible) return;

    isVisible = true;

    showDialog(
      barrierColor: AppPalette.black.withValues(alpha: 0.5),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: PopScope(
            canPop: false,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [const SizedBox(height: 50, width: 50, child: CircularProgressIndicator())],
              ),
            ),
          ),
        );
      },
      context: context,
    );
  }
}
