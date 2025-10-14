import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';

abstract interface class DashboardRepository {
  Future<ApiResult<List<Game>>> getGames();
  Future<ApiResult<GameOverview>> getGameOverview(int id);
}