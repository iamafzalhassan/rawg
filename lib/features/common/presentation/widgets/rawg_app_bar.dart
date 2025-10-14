import 'package:flutter/material.dart';
import 'package:rawg/core/constants/asset_constants.dart';

class RAWGAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RAWGAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(AssetConstants.logoMinimal, width: 95.0),
    );
  }
}