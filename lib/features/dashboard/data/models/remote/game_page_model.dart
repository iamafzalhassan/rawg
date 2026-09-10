import 'package:rawg/features/dashboard/data/models/remote/game_model.dart';
import 'package:rawg/features/dashboard/domain/entities/game_page.dart';

class GamePageModel extends GamePage {
  GamePageModel({required super.hasMore, required super.page, required super.games});

  factory GamePageModel.fromJson(Map<String, dynamic> json, int page) => GamePageModel(hasMore: json["next"] != null, page: page, games: List<GameModel>.from((json["results"] as List).map((x) => GameModel.fromJson(x))));
}
