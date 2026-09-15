import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    cursorColor: AppPalette.white,
    decoration: InputDecoration(
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.all(16.0),
      filled: true,
      fillColor: AppPalette.gray4,
      hintStyle: AppFont.style(color: AppPalette.gray1, fontSize: 18.0),
      hintText: 'dashboard.searchHint'.tr(),
      prefixIcon: Padding(padding: const EdgeInsets.all(12.0), child: Image.asset(AssetConstants.searchIcon, width: 18.0)),
    ),
    onChanged: context.read<DashboardCubit>().onSearchChanged,
    style: AppFont.style(color: AppPalette.white, fontSize: 18.0),
  );
}
