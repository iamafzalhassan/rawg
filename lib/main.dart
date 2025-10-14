import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/di/injection_container.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';

import 'app.dart';
import 'features/dashboard/presentation/cubits/sort_chip_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SortChipCubit>()),
        BlocProvider(create: (_) => sl<DashboardCubit>()..getGames()),
      ],
      child: const App(),
    ),
  );
}