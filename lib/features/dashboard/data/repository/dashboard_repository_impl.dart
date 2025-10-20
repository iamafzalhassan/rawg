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

      if (!isConnected) {
        return ApiFailure(message: "errors.noInternet".tr());
      }

      final result = await remoteDataSource.getGames(
        page: page,
        pageSize: pageSize,
        platforms: platforms,
        searchQuery: searchQuery,
      );

      if (result case ApiSuccess<List<GameModel>>(data: final games)) {
        final filteredGames = games.where((game) {
          final metacritic = game.metacritic ?? 0;
          return metacritic > 0;
        }).toList();

        return ApiSuccess<List<Game>>(filteredGames);
      }

      return result as ApiFailure<List<Game>>;
    } catch (e) {
      return ApiFailure(message: "errors.default".tr());
    }
  }

  @override
  Future<ApiResult<GameOverview>> getGameOverview(int id) async {
    try {
      final isConnected = await connectionChecker.isConnected;

      if (isConnected) {
        final result = await remoteDataSource.getGameOverview(id);

        if (result case ApiSuccess<GameOverview>(data: final overview)) {
          await localDataSource.cacheGameOverview(overview).catchError((e) => {});
          return result;
        }

        return await getCachedGameOverview(id);
      } else {
        return await getCachedGameOverview(id);
      }
    } catch (e) {
      return await getCachedGameOverview(id);
    }
  }

  Future<ApiResult<GameOverview>> getCachedGameOverview(int id) async {
    try {
      final cachedOverview = await localDataSource.getCachedGameOverview(id);

      if (cachedOverview != null) {
        return ApiSuccess(cachedOverview);
      }

      return ApiFailure(message: 'errors.noCache'.tr());
    } catch (e) {
      return ApiFailure(message: 'errors.noCache'.tr());
    }
  }
}