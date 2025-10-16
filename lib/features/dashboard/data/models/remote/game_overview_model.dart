import 'package:rawg/features/dashboard/data/models/remote/publisher_model.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class GameOverviewModel extends GameOverview {
  GameOverviewModel({
    required super.id,
    required super.metacritic,
    required super.website,
    required super.playtime,
    required super.publishers,
    required super.descriptionRaw,
  });

  GameOverviewModel copyWith({
    int? id,
    int? metacritic,
    String? website,
    int? playtime,
    List<Publisher>? publishers,
    String? descriptionRaw,
  }) =>
      GameOverviewModel(
        id: id ?? this.id,
        metacritic: metacritic ?? this.metacritic,
        website: website ?? this.website,
        playtime: playtime ?? this.playtime,
        publishers: publishers ?? this.publishers,
        descriptionRaw: descriptionRaw ?? this.descriptionRaw,
      );

  factory GameOverviewModel.fromJson(Map<String, dynamic> json) =>
      GameOverviewModel(
        id: json["id"],
        metacritic: json["metacritic"],
        website: json["website"],
        playtime: json["playtime"],
        publishers: List<PublisherModel>.from(json["publishers"].map((x) => PublisherModel.fromJson(x))),
        descriptionRaw: json["description_raw"],
      );
}