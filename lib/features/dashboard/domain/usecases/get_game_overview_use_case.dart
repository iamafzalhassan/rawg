import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/repository/dashboard_repository.dart';

class GetGameOverviewUseCase {
  final DashboardRepository dashboardRepository;

  GetGameOverviewUseCase(this.dashboardRepository);

  Future<ApiResult<GameOverview>> call(int id) async {
    return await dashboardRepository.getGameOverview(id);
  }
}