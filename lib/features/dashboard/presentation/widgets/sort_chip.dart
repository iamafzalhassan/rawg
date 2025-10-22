import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_bottom_sheet.dart';
import 'package:rawg/features/dashboard/presentation/widgets/sort_bottom_sheet.dart';

class SortChip extends StatelessWidget {
  const SortChip({
    required this.value,
    this.isLoading = false,
    super.key,
  });

  final String value;
  final bool isLoading;

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
              style: AppFont.style(color: AppPalette.white, fontSize: 15.0),
            ),
            const SizedBox(width: 5.0),
            if (isLoading)
              const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Image.asset(AssetConstants.chevronIcon, width: 15.0),
          ],
        ),
      ),
    );
  }
}