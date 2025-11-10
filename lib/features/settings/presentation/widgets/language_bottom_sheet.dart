import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/constants/locale_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/common/presentation/widgets/dashed_divider.dart';
import 'package:rawg/features/settings/presentation/cubits/settings_cubit.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = LocaleConstants.languages;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16.0),
              child: Text(
                'settings.selectLanguage'.tr(),
                style: AppFont.style(color: AppPalette.white, fontSize: 25),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 16.0),
            ...List.generate(
              languages.length,
              (i) => buildLanguageItem(
                context,
                languages[i]['locale'] as Locale,
                languages[i]['name'] as String,
                i,
                languages.length,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }

  Widget buildLanguageItem(
    BuildContext context,
    Locale locale,
    String name,
    int index,
    int length,
  ) {
    final isSelected = context.locale == locale;

    return GestureDetector(
      onTap: () => onLanguageSelected(context, locale),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: AppFont.style(color: AppPalette.white, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppPalette.green1 : null,
                    shape: BoxShape.circle,
                    border: isSelected ? null : Border.all(color: AppPalette.gray2),
                  ),
                  height: 20,
                  padding: const EdgeInsets.all(2.0),
                  width: 20,
                  child: isSelected ? Image.asset(AssetConstants.tickIcon) : null,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (index != length - 1) ...[
              const DashedDivider(color: AppPalette.gray2),
              const SizedBox(height: 8.0),
            ],
          ],
        ),
      ),
    );
  }

  void onLanguageSelected(BuildContext context, Locale locale) async {
    await context.setLocale(locale);

    if (context.mounted) {
      context.read<SettingsCubit>().setCurrentLocale(locale);
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}