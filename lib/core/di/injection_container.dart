import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rawg/core/network/api_request.dart';
import 'package:rawg/core/network/connection_checker.dart';
import 'package:rawg/features/auth/cubits/auth_cubit.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:rawg/features/dashboard/data/models/local/hive_game_overview_model.dart';
import 'package:rawg/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_game_overview_use_case.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_games_use_case.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:rawg/features/dashboard/presentation/cubits/sort_chip_cubit.dart';
import 'package:rawg/features/settings/presentation/cubits/settings_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initHive();
  await initCommon();
  await initDashboard();
}

Future<void> initCommon() async {
  sl.registerLazySingleton<ApiRequest>(() => ApiRequest());

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(InternetConnection()));

  sl.registerFactory(() => AuthCubit());

  sl.registerFactory(() => SortChipCubit());

  sl.registerFactory(() => SettingsCubit());
}

Future<void> initHive() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(HiveGameOverviewModelAdapter());
  }
}

Future<void> initDashboard() async {
  sl.registerLazySingleton<DashboardRemoteDataSource>(() => DashboardRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<DashboardLocalDataSource>(() => DashboardLocalDataSourceImpl());

  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(sl(), sl(), sl()));

  sl.registerLazySingleton(() => GetGamesUseCase(sl()));
  sl.registerLazySingleton(() => GetGameOverviewUseCase(sl()));

  sl.registerFactory(() => DashboardCubit(sl(), sl()));
}