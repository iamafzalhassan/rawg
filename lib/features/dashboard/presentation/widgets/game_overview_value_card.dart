import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class GameOverviewValueCard extends StatelessWidget {
  final double? width;
  final String label;
  final String? value;
  final Widget? child;

  const GameOverviewValueCard(
      this.label, {
        super.key,
        this.width,
        this.value,
        this.child,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFont.style(
            fontSize: 10.0,
            color: AppPalette.gray4,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 2.0),
        if (child != null) child!,
        if (value != null)
          SizedBox(
            width: width ?? (((MediaQuery.of(context).size.width - 32) / 2) - 10),
            child: Text(
              value!,
              style: AppFont.style(
                fontSize: 12.0,
                color: AppPalette.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
      ],
    );
  }
}