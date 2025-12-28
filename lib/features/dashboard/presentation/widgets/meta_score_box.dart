import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class MetaScoreBox extends StatelessWidget {
  final int metacritic;

  const MetaScoreBox(this.metacritic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppPalette.green1),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      height: 35.0,
      padding: EdgeInsets.all(8.0),
      width: 35.0,
      child: Text(
        '$metacritic',
        style: AppFont.style(
          fontSize: 12.0,
          color: AppPalette.green1,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}