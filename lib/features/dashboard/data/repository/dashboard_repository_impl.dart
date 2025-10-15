import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DashboardRepositoryImpl(this.dashboardRemoteDataSource);

  @override
  Future<ApiResult<List<Game>>> getGames({int page = 1, int pageSize = 20}) {
    return dashboardRemoteDataSource.getGames(page: page, pageSize: pageSize);
  }

  @override
  Future<ApiResult<GameOverview>> getGameOverview(int id) {
    return dashboardRemoteDataSource.getGameOverview(id);
  }
}