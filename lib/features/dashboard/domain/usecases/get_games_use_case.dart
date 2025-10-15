import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';

class GetGamesUseCase {
  final DashboardRepository dashboardRepository;

  GetGamesUseCase(this.dashboardRepository);

  Future<ApiResult<List<Game>>> call({
    int page = 1,
    int pageSize = 20,
    String? ordering,
    String? platforms,
  }) async {
    return await dashboardRepository.getGames(
      page: page,
      pageSize: pageSize,
      ordering: ordering,
      platforms: platforms,
    );
  }
}