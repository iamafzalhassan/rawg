import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_bottom_sheet.dart';
import 'package:rawg/core/utils/show_snackbar.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_app_bar.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_button.dart';
import 'package:rawg/features/settings/presentation/cubits/settings_cubit.dart';
import 'package:rawg/features/settings/presentation/widgets/language_bottom_sheet.dart';
import 'package:rawg/features/settings/presentation/widgets/settings_item.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) => previous.signedOut != current.signedOut || previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          showSnackBar(context, state.errorMessage!);
        }

        if (state.signedOut) {
          context.goNamed(RouteConstants.auth);
        }
      },
      child: Scaffold(
        appBar: RAWGAppBar(
          showLogo: false,
          title: 'settings.title'.tr(),
          showBackButton: true,
          showSettingsButton: false,
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
                  const Spacer(),
                  RAWGButton.elevated(
                    label: state.isLoading ? 'settings.signingOut'.tr() : 'settings.signOut'.tr(),
                    onPressed: state.isLoading ? null : () => context.read<SettingsCubit>().signOut(),
                    backgroundColor: AppPalette.gray4,
                    height: 55.0,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            );
          },
        ),
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