import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_bottom_sheet.dart';
import 'package:rawg/features/dashboard/presentation/widgets/sort_bottom_sheet.dart';

class SortChip extends StatelessWidget {
  const SortChip({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showBottomSheet(context, SortBottomSheet()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: AppPalette.gray6,
        ),
        height: 30.0,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: AppFont.style(color: AppPalette.white, fontSize: 12),
            ),
            SizedBox(width: 5.0),
            Image.asset(AssetConstants.chevronIcon, width: 15.0),
          ],
        ),
      ),
    );
  }
}