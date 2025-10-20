import 'package:hive_flutter/hive_flutter.dart';
import 'package:rawg/features/dashboard/data/models/local/hive_game_overview_model.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';

abstract interface class DashboardLocalDataSource {
  Future<void> cacheGameOverview(GameOverview overview);
  Future<GameOverview?> getCachedGameOverview(int id);
  Future<void> clearCache();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  static const String boxName = 'game-overview-cache';

  Box<HiveGameOverviewModel>? hiveGameOverviewBox;

  Future<Box<HiveGameOverviewModel>> get box async {
    return hiveGameOverviewBox ??= await Hive.openBox<HiveGameOverviewModel>(boxName);
  }

  @override
  Future<void> cacheGameOverview(GameOverview overview) async {
    final overviewBox = await box;
    final hiveModel = HiveGameOverviewModel.fromGameOverview(overview);
    await overviewBox.put('overview-${overview.id}', hiveModel);
  }

  @override
  Future<GameOverview?> getCachedGameOverview(int id) async {
    final overviewBox = await box;
    final cached = overviewBox.get('overview-$id');

    if (cached != null && !cached.isStale) {
      return cached.toGameOverview();
    }

    return null;
  }

  @override
  Future<void> clearCache() async {
    final overviewBox = await box;
    await overviewBox.clear();
  }
}