import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rawg/core/configs/app_router.dart';
import 'package:rawg/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'appTitle'.tr(),
      theme: AppTheme.darkMode,
      routerConfig: AppRouter.router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}