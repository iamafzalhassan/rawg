import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rawg/core/network/api_request.dart';
import 'package:rawg/core/network/connection_checker.dart';
import 'package:rawg/core/secrets/app_secret.dart';
import 'package:rawg/core/services/onesignal_service.dart';
import 'package:rawg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rawg/features/auth/data/repository/auth_repository_impl.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';
import 'package:rawg/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:rawg/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:rawg/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:rawg/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:rawg/features/auth/presentation/cubits/auth_cubit.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initHive();
  await initSupabase();
  await initOnesignal();
  await initCommon();
  await initAuth();
  await initDashboard();
}

Future<void> initHive() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(HiveGameOverviewModelAdapter());
  }
}

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: AppSecret.supaBaseUrl,
    anonKey: AppSecret.supaBaseApiKey,
  );

  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}

Future<void> initOnesignal() async {
  sl.registerLazySingleton<OneSignalService>(() => OneSignalService());
}

Future<void> initCommon() async {
  sl.registerLazySingleton<ApiRequest>(() => ApiRequest());

  sl.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(InternetConnection()),
  );

  sl.registerFactory(() => SortChipCubit());

  sl.registerFactory(() => SettingsCubit(sl(), sl()));
}

Future<void> initAuth() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
}

Future<void> initDashboard() async {
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl(), sl(), sl()),
  );

  sl.registerLazySingleton(() => GetGamesUseCase(sl()));
  sl.registerLazySingleton(() => GetGameOverviewUseCase(sl()));

  sl.registerFactory(() => DashboardCubit(sl(), sl()));
}