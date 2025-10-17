import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/di/injection_container.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:rawg/features/dashboard/presentation/cubits/sort_chip_cubit.dart';
import 'package:rawg/features/settings/presentation/cubits/settings_cubit.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('si', 'LK')],
      path: 'assets/locales',
      fallbackLocale: const Locale('en', 'US'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<SortChipCubit>()),
          BlocProvider(create: (_) => sl<DashboardCubit>()..getGames()),
          BlocProvider(create: (_) => sl<SettingsCubit>()),
        ],
        child: const App(),
      ),
    ),
  );
}