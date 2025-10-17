import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/constants/route_constants.dart';

class RAWGAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RAWGAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(AssetConstants.logoMinimal, width: 95.0),
      actions: [
        GestureDetector(
          onTap: () => context.pushNamed(RouteConstants.settings),
          child: Image.asset(AssetConstants.settingIcon, width: 24.0),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}