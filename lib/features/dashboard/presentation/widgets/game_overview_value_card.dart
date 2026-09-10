import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class GameOverviewValueCard extends StatelessWidget {
  const GameOverviewValueCard(this.label, {super.key, this.width, this.value, this.child});

  final double? width;

  final String label;
  final String? value;

  final Widget? child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppFont.style(color: AppPalette.gray4, fontSize: 10.0),
        textAlign: TextAlign.left,
      ),
      SizedBox(height: 2.0),
      if (child != null) child!,
      if (value != null)
        SizedBox(
          width: width ?? (((MediaQuery.of(context).size.width - 32) / 2) - 10),
          child: Text(
            value!,
            style: AppFont.style(color: AppPalette.white, fontSize: 12.0),
            textAlign: TextAlign.left,
          ),
        ),
    ],
  );
}
