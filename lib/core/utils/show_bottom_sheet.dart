import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_pallete.dart';

void showBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    backgroundColor: AppPalette.gray6,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8.0),
            Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                color: AppPalette.gray2,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16.0),
            child,
          ],
        ),
      );
    },
  );
}