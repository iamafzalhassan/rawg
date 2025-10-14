import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class MetaScoreBox extends StatelessWidget {
  const MetaScoreBox(this.metacritic, {super.key});

  final int metacritic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        border: Border.all(color: AppPalette.green1),
      ),
      height: 35,
      padding: EdgeInsets.all(8.0),
      width: 35,
      child: Text(
        '$metacritic',
        style: AppFont.style(color: AppPalette.green1, fontSize: 12),
        textAlign: TextAlign.left,
      ),
    );
  }
}