import 'package:rawg/features/dashboard/data/models/remote/esrb_rating_model.dart';
import 'package:rawg/features/dashboard/data/models/remote/genre_model.dart';
import 'package:rawg/features/dashboard/data/models/remote/parent_platform_model.dart';
import 'package:rawg/features/dashboard/data/models/remote/store_model.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';

class GameModel extends Game {
  GameModel({
    required super.tba,
    required super.added,
    required super.id,
    required super.metacritic,
    required super.playtime,
    required super.ratingsCount,
    required super.reviewsCount,
    required super.reviewsTextCount,
    required super.suggestionsCount,
    required super.backgroundImage,
    required super.dominantColor,
    required super.name,
    required super.saturatedColor,
    required super.slug,
    required super.released,
    required super.esrbRating,
    required super.genres,
    required super.parentPlatforms,
    required super.stores,
  });

  GameModel copyWith({
    bool? tba,
    int? added,
    int? id,
    int? metacritic,
    int? playtime,
    int? ratingsCount,
    int? reviewsCount,
    int? reviewsTextCount,
    int? suggestionsCount,
    String? backgroundImage,
    String? dominantColor,
    String? name,
    String? saturatedColor,
    String? slug,
    DateTime? released,
    EsrbRatingModel? esrbRating,
    List<GenreModel>? genres,
    List<ParentPlatformModel>? parentPlatforms,
    List<StoreModel>? stores,
  }) => GameModel(
    tba: tba ?? this.tba,
    added: added ?? this.added,
    id: id ?? this.id,
    metacritic: metacritic ?? this.metacritic,
    playtime: playtime ?? this.playtime,
    ratingsCount: ratingsCount ?? this.ratingsCount,
    reviewsCount: reviewsCount ?? this.reviewsCount,
    reviewsTextCount: reviewsTextCount ?? this.reviewsTextCount,
    suggestionsCount: suggestionsCount ?? this.suggestionsCount,
    backgroundImage: backgroundImage ?? this.backgroundImage,
    dominantColor: dominantColor ?? this.dominantColor,
    name: name ?? this.name,
    saturatedColor: saturatedColor ?? this.saturatedColor,
    slug: slug ?? this.slug,
    released: released ?? this.released,
    esrbRating: esrbRating ?? this.esrbRating,
    genres: genres ?? this.genres,
    parentPlatforms: parentPlatforms ?? this.parentPlatforms,
    stores: stores ?? this.stores,
  );

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
    tba: json["tba"] ?? false,
    added: json["added"] ?? 0,
    id: json["id"],
    metacritic: json["metacritic"] ?? 0,
    playtime: json["playtime"] ?? 0,
    ratingsCount: json["ratings_count"] ?? 0,
    reviewsCount: json["reviews_count"] ?? 0,
    reviewsTextCount: json["reviews_text_count"] ?? 0,
    suggestionsCount: json["suggestions_count"] ?? 0,
    backgroundImage: json["background_image"] ?? '',
    dominantColor: json["dominant_color"] ?? '0f0f0f',
    name: json["name"] ?? '',
    saturatedColor: json["saturated_color"] ?? '0f0f0f',
    slug: json["slug"] ?? '',
    released: json["released"] != null
        ? DateTime.parse(json["released"])
        : DateTime.now(),
    esrbRating: json["esrb_rating"] != null
        ? EsrbRatingModel.fromJson(json["esrb_rating"])
        : null,
    genres: json["genres"] != null
        ? List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x)),
          )
        : [],
    parentPlatforms: json["parent_platforms"] != null
        ? List<ParentPlatformModel>.from(
            json["parent_platforms"].map(
              (x) => ParentPlatformModel.fromJson(x),
            ),
          )
        : [],
    stores: json["stores"] != null
        ? List<StoreModel>.from(
            json["stores"].map((x) => StoreModel.fromJson(x)),
          )
        : [],
  );
}