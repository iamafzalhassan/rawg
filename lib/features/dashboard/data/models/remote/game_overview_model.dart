import 'package:rawg/features/dashboard/data/models/remote/publisher_model.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class GameOverviewModel extends GameOverview {
  GameOverviewModel({
    required super.id,
    required super.metacritic,
    required super.playtime,
    required super.descriptionRaw,
    required super.website,
    required super.publishers,
  });

  GameOverviewModel copyWith({
    int? id,
    int? metacritic,
    int? playtime,
    String? descriptionRaw,
    String? website,
    List<Publisher>? publishers,
  }) => GameOverviewModel(
    id: id ?? this.id,
    metacritic: metacritic ?? this.metacritic,
    playtime: playtime ?? this.playtime,
    descriptionRaw: descriptionRaw ?? this.descriptionRaw,
    website: website ?? this.website,
    publishers: publishers ?? this.publishers,
  );

  factory GameOverviewModel.fromJson(Map<String, dynamic> json) =>
      GameOverviewModel(
        id: json["id"],
        metacritic: json["metacritic"],
        website: json["website"],
        playtime: json["playtime"],
        publishers: List<PublisherModel>.from(
          json["publishers"].map((x) => PublisherModel.fromJson(x)),
        ),
        descriptionRaw: json["description_raw"],
      );
}