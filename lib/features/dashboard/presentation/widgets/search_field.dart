import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppFont.style(color: AppPalette.white, fontSize: 18.0),
      cursorColor: AppPalette.white,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: AppPalette.gray5,
        hintStyle: AppFont.style(fontSize: 18.0, color: AppPalette.gray1),
        hintText: 'dashboard.searchHint'.tr(),
        prefixIcon: Image.asset(AssetConstants.searchIcon, width: 18.0),
      ),
    );
  }
}