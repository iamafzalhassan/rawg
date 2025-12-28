import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class RAWGAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showLogo;
  final bool showSettingsButton;
  final String? title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const RAWGAppBar({
    super.key,
    this.showBackButton = false,
    this.showLogo = true,
    this.showSettingsButton = true,
    this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: buildActions(context),
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: buildLeading(context),
      title: buildTitle(),
    );
  }

  List<Widget>? buildActions(BuildContext context) {
    if (actions != null) {
      return actions;
    }

    if (showSettingsButton && !showBackButton) {
      return [
        GestureDetector(
          onTap: () => context.pushNamed(RouteConstants.settings),
          child: Image.asset(AssetConstants.settingIcon, width: 24.0),
        ),
        const SizedBox(width: 16),
      ];
    }

    return null;
  }

  Widget? buildLeading(BuildContext context) {
    if (showBackButton) {
      return GestureDetector(
        onTap: onBackPressed ?? () => context.pop(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(AssetConstants.leftArrowIcon),
        ),
      );
    }
    return null;
  }

  Widget? buildTitle() {
    if (showLogo) {
      return Image.asset(AssetConstants.logoMinimal, width: 95.0);
    } else if (title != null) {
      return Text(
        title!,
        style: AppFont.style(fontSize: 20.0, color: AppPalette.white),
      );
    }
    return null;
  }
}