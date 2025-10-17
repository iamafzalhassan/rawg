import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_bottom_sheet.dart';
import 'package:rawg/features/settings/presentation/cubits/settings_cubit.dart';
import 'package:rawg/features/settings/presentation/widgets/language_bottom_sheet.dart';
import 'package:rawg/features/settings/presentation/widgets/settings_item.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(AssetConstants.leftArrowIcon),
          ),
        ),
        title: Text(
          'settings.title'.tr(),
          style: AppFont.style(color: AppPalette.white, fontSize: 20),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SettingsItem(
                  'settings.language'.tr(),
                  value: getCurrentLanguageName(context),
                  onTap: () => showLanguageBottomSheet(context),
                ),
                const SizedBox(height: 12.0),
                SettingsItem(
                  'settings.notifications'.tr(),
                  showToggle: true,
                  toggleValue: state.notificationsEnabled,
                  onToggleChanged: (value) => context.read<SettingsCubit>().setNotificationsEnabled(value),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getCurrentLanguageName(BuildContext context) {
    if (context.locale == const Locale('en', 'US')) {
      return 'languages.english'.tr();
    } else if (context.locale == const Locale('si', 'LK')) {
      return 'languages.sinhala'.tr();
    }
    return 'languages.english'.tr();
  }

  void showLanguageBottomSheet(BuildContext context) {
    showBottomSheet(context, const LanguageBottomSheet());
  }
}