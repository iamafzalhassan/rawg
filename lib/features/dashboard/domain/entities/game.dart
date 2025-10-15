import 'package:rawg/features/dashboard/domain/entities/esrb_rating.dart';
import 'package:rawg/features/dashboard/domain/entities/genre.dart';
import 'package:rawg/features/dashboard/domain/entities/parent_platform.dart';
import 'package:rawg/features/dashboard/domain/entities/store.dart';

class Game {
  int id;
  String slug;
  String name;
  DateTime released;
  bool tba;
  String backgroundImage;
  int ratingsCount;
  int reviewsTextCount;
  int added;
  int metacritic;
  int playtime;
  int suggestionsCount;
  int reviewsCount;
  String saturatedColor;
  String dominantColor;
  List<ParentPlatform> parentPlatforms;
  List<Genre> genres;
  List<Store> stores;
  EsrbRating? esrbRating;

  Game({
    required this.id,
    required this.slug,
    required this.name,
    required this.released,
    required this.tba,
    required this.backgroundImage,
    required this.ratingsCount,
    required this.reviewsTextCount,
    required this.added,
    required this.metacritic,
    required this.playtime,
    required this.suggestionsCount,
    required this.reviewsCount,
    required this.saturatedColor,
    required this.dominantColor,
    required this.parentPlatforms,
    required this.genres,
    required this.stores,
    this.esrbRating,
  });
}