import 'package:get_it/get_it.dart';
import 'package:rawg/core/network/api_request.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:rawg/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_game_overview_use_case.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_games_use_case.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:rawg/features/dashboard/presentation/cubits/sort_chip_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initCommon();
  await initDashboard();
}

Future<void> initCommon() async {
  sl.registerLazySingleton<ApiRequest>(() => ApiRequest());

  sl.registerFactory(() => SortChipCubit());
}

Future<void> initDashboard() async {
  // Data sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(() => DashboardRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetGamesUseCase(sl()));
  sl.registerLazySingleton(() => GetGameOverviewUseCase(sl()));

  // Bloc
  sl.registerFactory(() => DashboardCubit(sl(), sl()));
}