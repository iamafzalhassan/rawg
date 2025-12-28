import 'package:flutter/cupertino.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class SettingsItem extends StatelessWidget {
  final bool showDropDown;
  final bool showToggle;
  final bool toggleValue;
  final String label;
  final String? value;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggleChanged;

  const SettingsItem(
      this.label, {
        super.key,
        this.showDropDown = false,
        this.showToggle = false,
        this.toggleValue = false,
        this.value,
        this.onTap,
        this.onToggleChanged,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showToggle ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppPalette.black1,
        ),
        height: 80.0,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: AppFont.style(
                      fontSize: 18,
                      color: AppPalette.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (value != null) ...[
                    SizedBox(height: 4.0),
                    Text(
                      value!,
                      style: AppFont.style(
                        fontSize: 14,
                        color: AppPalette.gray1,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showToggle)
              CupertinoSwitch(
                activeTrackColor: AppPalette.green1,
                inactiveThumbColor: AppPalette.gray1,
                inactiveTrackColor: AppPalette.gray4,
                onChanged: onToggleChanged,
                value: toggleValue,
              ),
            if (showDropDown)
              Image.asset(AssetConstants.chevronIcon, width: 20.0),
          ],
        ),
      ),
    );
  }
}