import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class RAWGButton extends StatelessWidget {
  const RAWGButton(this.label, this.onTap, {this.icon, super.key});

  final String label;
  final String? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        icon: icon != null ? Image.asset(icon!, width: 20.0) : null,
        label: Text(
          label,
          style: AppFont.style(color: AppPalette.white, fontSize: 20.0),
        ),
        onPressed: () => onTap(),
      ),
    );
  }
}