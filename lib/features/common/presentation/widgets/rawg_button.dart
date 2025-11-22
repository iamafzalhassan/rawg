import 'package:flutter/material.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class RAWGButton extends StatelessWidget {
  const RAWGButton.elevated({
    super.key,
    this.isLoading = false,
    this.isOutlined = false,
    required this.label,
    this.icon,
    this.borderRadius = 8.0,
    this.backgroundColor,
    this.textColor,
    required this.onPressed,
  });

  const RAWGButton.outlined({
    super.key,
    this.isLoading = false,
    this.isOutlined = true,
    required this.label,
    this.icon,
    this.borderRadius = 8.0,
    this.backgroundColor,
    this.textColor,
    required this.onPressed,
  });

  final bool isLoading;
  final bool isOutlined;
  final String label;
  final String? icon;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return SizedBox(
        height: 55.0,
        width: double.infinity,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            side: BorderSide(
              color: backgroundColor ?? AppPalette.gray6,
              width: 2.0,
            ),
          ),
          child: buildChild(),
        ),
      );
    }

    return SizedBox(
      height: 55.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppPalette.gray6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0.0,
        ),
        child: buildChild(),
      ),
    );
  }

  Widget buildChild() {
    if (isLoading) {
      return SizedBox(
        height: 24.0,
        width: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? AppPalette.white,
          ),
        ),
      );
    }

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
              fontSize: 18.0,
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
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}