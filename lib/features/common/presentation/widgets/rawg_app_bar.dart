import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

class RAWGAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RAWGAppBar({super.key, this.showBackButton = false, this.showLogo = true, this.showSettingsButton = true, this.title, this.actions, this.onBackPressed});

  final bool showBackButton;
  final bool showLogo;
  final bool showSettingsButton;

  final String? title;

  final List<Widget>? actions;

  final VoidCallback? onBackPressed;

  List<Widget>? buildActions(BuildContext context) {
    if (actions != null) {
      return actions;
    }

    if (showSettingsButton && !showBackButton) {
      return [GestureDetector(onTap: () => context.pushNamed(RouteConstants.settings), child: Image.asset(AssetConstants.settingIcon, width: 24.0)), const SizedBox(width: 16)];
    }

    return null;
  }

  Widget? buildLeading(BuildContext context) {
    if (showBackButton) {
      return GestureDetector(
        onTap: onBackPressed ?? () => context.pop(),
        child: Padding(padding: const EdgeInsets.all(16.0), child: Image.asset(AssetConstants.leftArrowIcon)),
      );
    }
    return null;
  }

  Widget? buildTitle() {
    if (showLogo) {
      return Image.asset(AssetConstants.logoMinimal, width: 95.0);
    } else if (title != null) {
      return Text(title!, style: AppFont.style(color: AppPalette.white, fontSize: 20.0));
    }
    return null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(actions: buildActions(context), automaticallyImplyLeading: false, centerTitle: true, leading: buildLeading(context), title: buildTitle());
}
