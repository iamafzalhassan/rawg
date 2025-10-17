import 'package:flutter/cupertino.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
    this.label, {
    super.key,
    this.value,
    this.showToggle = false,
    this.toggleValue = false,
    this.onTap,
    this.onToggleChanged,
  });

  final String label;
  final String? value;
  final bool showToggle;
  final bool toggleValue;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggleChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showToggle ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppPalette.black1,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppFont.style(
                      color: AppPalette.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (value != null) ...[
                    SizedBox(height: 4.0),
                    Text(
                      value!,
                      style: AppFont.style(
                        color: AppPalette.gray1,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showToggle)
              CupertinoSwitch(
                value: toggleValue,
                onChanged: onToggleChanged,
                activeTrackColor: AppPalette.green1,
                inactiveThumbColor: AppPalette.gray1,
                inactiveTrackColor: AppPalette.gray4,
              )
            else
              Image.asset(AssetConstants.chevronIcon, width: 20.0),
          ],
        ),
      ),
    );
  }
}