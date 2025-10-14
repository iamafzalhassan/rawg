import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';

class GetGamesUseCase {
  final DashboardRepository dashboardRepository;

  GetGamesUseCase(this.dashboardRepository);

  Future<ApiResult<List<Game>>> call() async {
    return await dashboardRepository.getGames();
  }
}