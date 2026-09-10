import 'package:easy_localization/easy_localization.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/core/network/connection_checker.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/entities/game_page.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final ConnectionChecker connectionChecker;

  final DashboardLocalDataSource localDataSource;

  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource, this.localDataSource, this.connectionChecker);

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

  @override
  Future<ApiResult<GameOverview>> getGameOverview(int id) async {
    try {
      final isConnected = await connectionChecker.isConnected;

      if (isConnected) {
        final result = await remoteDataSource.getGameOverview(id);

        if (result case ApiSuccess<GameOverview>(data: final overview)) {
          await localDataSource.cacheGameOverview(overview);
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

  @override
  Future<ApiResult<GamePage>> getGames({int page = 1, int pageSize = 20, String? platforms, String? searchQuery}) async {
    try {
      final isConnected = await connectionChecker.isConnected;

      if (!isConnected) {
        return ApiFailure(message: "errors.noInternet".tr());
      }

      return await remoteDataSource.getGames(page: page, pageSize: pageSize, platforms: platforms, searchQuery: searchQuery);
    } catch (e) {
      return ApiFailure(message: "errors.default".tr());
    }
  }
}
