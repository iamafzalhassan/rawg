import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';

class GetGamesUseCase {
  final DashboardRepository _dashboardRepository;

  GetGamesUseCase(this._dashboardRepository);

  Future<ApiResult<List<Game>>> call({
    int page = 1,
    int pageSize = 20,
    String? platforms,
    String? searchQuery,
  }) async {
    return await _dashboardRepository.getGames(
      page: page,
      pageSize: pageSize,
      platforms: platforms,
      searchQuery: searchQuery,
    );
  }
}