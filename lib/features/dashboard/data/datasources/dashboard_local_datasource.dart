import 'package:hive_flutter/hive_flutter.dart';
import 'package:rawg/features/dashboard/data/models/local/hive_game_model.dart';
import 'package:rawg/features/dashboard/data/models/remote/game_model.dart';

abstract interface class DashboardLocalDataSource {
  Future<void> cacheGames(
    List<GameModel> games, {
    int page = 1,
    String? ordering,
    String? platforms,
  });

  Future<List<GameModel>> getCachedGames({
    int page = 1,
    String? ordering,
    String? platforms,
  });

  Future<void> clearCache();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  static const String boxName = 'games-cache';

  Box<HiveGameModel>? hiveGameModelBox;

  Future<Box<HiveGameModel>> get box async {
    return hiveGameModelBox ??= await Hive.openBox<HiveGameModel>(boxName);
  }

  @override
  Future<void> cacheGames(
    List<GameModel> games, {
    int page = 1,
    String? ordering,
    String? platforms,
  }) async {
    final gamesBox = await box;
    final cacheKey = generateCacheKey(
      page: page,
      ordering: ordering,
      platforms: platforms,
    );

    await clearPageCache(cacheKey);

    for (var i = 0; i < games.length; i++) {
      final hiveModel = HiveGameModel.fromGameModel(games[i]);
      await gamesBox.put('$cacheKey-$i', hiveModel);
    }
  }

  @override
  Future<List<GameModel>> getCachedGames({
    int page = 1,
    String? ordering,
    String? platforms,
  }) async {
    final gamesBox = await box;
    final cacheKey = generateCacheKey(
      page: page,
      ordering: ordering,
      platforms: platforms,
    );

    final cachedGames = gamesBox.values.where((game) => game.key.toString().startsWith(cacheKey)).toList();

    final validGames = cachedGames.where((game) => !game.isStale).toList();

    if (validGames.isEmpty && cachedGames.isNotEmpty) {
      await clearPageCache(cacheKey);
      return [];
    }

    return validGames.map((hiveModel) => hiveModel.toGameModel()).toList();
  }

  @override
  Future<void> clearCache() async {
    final gamesBox = await box;
    await gamesBox.clear();
  }

  String generateCacheKey({int page = 1, String? ordering, String? platforms}) {
    return 'games-p$page-o${ordering ?? 'none'}-pl${platforms ?? 'none'}';
  }

  Future<void> clearPageCache(String cacheKey) async {
    final gamesBox = await box;
    final keysToDelete = gamesBox.keys.where((key) => key.toString().startsWith(cacheKey)).toList();

    for (var key in keysToDelete) {
      await gamesBox.delete(key);
    }
  }
}