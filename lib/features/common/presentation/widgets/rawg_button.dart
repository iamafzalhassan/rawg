import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class RAWGButton extends StatelessWidget {
  const RAWGButton.elevated({
    super.key,
    required this.label,
    required this.onPressed,

    this.icon,
    this.width = double.infinity,
    this.height = 50.0,
    this.fontSize = 18.0,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.backgroundColor,
    this.textColor,
  }) : isOutlined = false;

  const RAWGButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,

    this.icon,
    this.width = double.infinity,
    this.height = 50.0,
    this.fontSize = 18.0,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.backgroundColor,
    this.textColor,
  }) : isOutlined = true;

  final String label;
  final VoidCallback? onPressed;

  final bool isOutlined;
  final String? icon;
  final double width;
  final double height;
  final double fontSize;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: backgroundColor ?? AppPalette.gray6,
              width: 4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: buildChild(),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppPalette.gray6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
        ),
        child: buildChild(),
      ),
    );
  }

  Widget buildChild() {
    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon!, width: 18.0),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: AppFont.style(
              color: textColor ?? AppPalette.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: AppFont.style(
        color: textColor ?? AppPalette.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}