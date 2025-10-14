import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class RAWGButton extends StatelessWidget {
  const RAWGButton(this.icon, this.label, {super.key});

  final String icon, label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        icon: Image.asset(icon, width: 20.0),
        label: Text(
          label,
          style: AppFont.style(color: AppPalette.white, fontSize: 20.0),
        ),
        onPressed: () {},
      ),
    );
  }
}