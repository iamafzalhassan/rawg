import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class GameOverviewValueCard extends StatelessWidget {
  const GameOverviewValueCard(
    this.label, {
    super.key,
    this.value,
    this.width,
    this.child,
  });

  final String label;
  final String? value;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFont.style(color: AppPalette.gray4, fontSize: 10),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 2.0),
        if (child != null) child!,
        if (value != null)
          SizedBox(
            width: width ?? (((MediaQuery.of(context).size.width - 32) / 2) - 10),
            child: Text(
              value!,
              style: AppFont.style(color: AppPalette.white, fontSize: 12),
              textAlign: TextAlign.left,
            ),
          ),
      ],
    );
  }
}