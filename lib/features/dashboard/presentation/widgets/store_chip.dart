import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class StoreChip extends StatelessWidget {
  const StoreChip(this.icon, this.label, {super.key});

  final String icon, label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        color: AppPalette.gray6,
      ),
      height: 30.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon, width: 15.0),
          SizedBox(width: 5.0),
          RichText(
            text: TextSpan(
              text: label,
              style: AppFont.style(color: AppPalette.gray3, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}