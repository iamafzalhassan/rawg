import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<DashboardCubit>().onSearchChanged(value),
      style: AppFont.style(color: AppPalette.white, fontSize: 18.0),
      cursorColor: AppPalette.white,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: AppPalette.gray5,
        hintStyle: AppFont.style(fontSize: 18.0, color: AppPalette.gray1),
        hintText: 'dashboard.searchHint'.tr(),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(AssetConstants.searchIcon, width: 18.0),
        ),
      ),
    );
  }
}