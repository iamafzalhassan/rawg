import 'package:easy_localization/easy_localization.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/core/network/connection_checker.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:rawg/features/dashboard/data/models/remote/game_model.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;

  DashboardRepositoryImpl(
      this.remoteDataSource,
      this.localDataSource,
      this.connectionChecker,
      );

  @override
  Future<ApiResult<List<Game>>> getGames({
    int page = 1,
    int pageSize = 20,
    String? ordering,
    String? platforms,
  }) async {
    try {
      final isConnected = await connectionChecker.isConnected;

      if (isConnected) {
        final result = await remoteDataSource.getGames(
          page: page,
          pageSize: pageSize,
          ordering: ordering,
          platforms: platforms,
        );

        if (result is ApiSuccess<List<GameModel>>) {
          await localDataSource.cacheGames(
            result.data,
            page: page,
            ordering: ordering,
            platforms: platforms,
          );

          return ApiSuccess<List<Game>>(result.data);
        } else {
          return await getCachedGames(page, ordering, platforms);
        }
      } else {
        return await getCachedGames(page, ordering, platforms);
      }
    } catch (e) {
      return await getCachedGames(page, ordering, platforms);
    }
  }

  Future<ApiResult<List<Game>>> getCachedGames(
      int page,
      String? ordering,
      String? platforms,
      ) async {
    try {
      final cachedGames = await localDataSource.getCachedGames(
        page: page,
        ordering: ordering,
        platforms: platforms,
      );

      if (cachedGames.isNotEmpty) {
        return ApiSuccess(cachedGames);
      } else {
        return ApiFailure(
          message: 'errors.noCache'.tr(),
        );
      }
    } catch (e) {
      return ApiFailure(message: e.toString());
    }
  }

  @override
  Future<ApiResult<GameOverview>> getGameOverview(int id) {
    return remoteDataSource.getGameOverview(id);
  }
}