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
    String? platforms,
    String? searchQuery,
  }) async {
    try {
      final isConnected = await connectionChecker.isConnected;

      if (isConnected) {
        return await _fetchAndCacheGames(
          page,
          pageSize,
          platforms,
          searchQuery,
        );
      } else {
        return await _getCachedGames(page, platforms);
      }
    } catch (e) {
      return await _getCachedGames(page, platforms);
    }
  }

  Future<ApiResult<List<Game>>> _fetchAndCacheGames(
    int page,
    int pageSize,
    String? platforms,
    String? searchQuery,
  ) async {
    final result = await remoteDataSource.getGames(
      page: page,
      pageSize: pageSize,
      platforms: platforms,
      searchQuery: searchQuery,
    );

    if (result case ApiSuccess<List<GameModel>>(data: final games)) {
      if (games.isNotEmpty && searchQuery == null) {
        localDataSource.cacheGames(games, page: page, platforms: platforms).catchError((e) => {});
      }
      return ApiSuccess<List<Game>>(games);
    }

    if (searchQuery == null) {
      return await _getCachedGames(page, platforms);
    }

    return result as ApiFailure<List<Game>>;
  }

  Future<ApiResult<List<Game>>> _getCachedGames(
    int page,
    String? platforms,
  ) async {
    try {
      final cachedGames = await localDataSource.getCachedGames(
        page: page,
        platforms: platforms,
      );

      if (cachedGames.isNotEmpty) {
        return ApiSuccess(cachedGames);
      }

      return ApiFailure(
        message: page == 1 ? 'errors.noCache'.tr() : 'errors.noMoreData'.tr(),
      );
    } catch (e) {
      return ApiFailure(
        message: page == 1 ? 'errors.noCache'.tr() : 'errors.noMoreData'.tr(),
      );
    }
  }

  @override
  Future<ApiResult<GameOverview>> getGameOverview(int id) => remoteDataSource.getGameOverview(id);
}