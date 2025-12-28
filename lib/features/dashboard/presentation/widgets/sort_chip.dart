import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_bottom_sheet.dart';
import 'package:rawg/features/dashboard/presentation/widgets/sort_bottom_sheet.dart';

class SortChip extends StatelessWidget {
  final bool isLoading;
  final String value;

  const SortChip({
    super.key,
    this.isLoading = false,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : () => showBottomSheet(context, const SortBottomSheet()),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: AppPalette.gray6,
        ),
        height: 40.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: AppFont.style(
                fontSize: 15.0,
                color: AppPalette.white,
              ),
            ),
            const SizedBox(width: 5.0),
            if (isLoading)
              const SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              )
            else
              Image.asset(AssetConstants.chevronIcon, width: 15.0),
          ],
        ),
      ),
    );
  }
}