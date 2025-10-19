import 'package:easy_localization/easy_localization.dart';
import 'package:rawg/features/dashboard/domain/entities/esrb_rating.dart';
import 'package:rawg/features/dashboard/domain/entities/genre.dart';
import 'package:rawg/features/dashboard/domain/entities/parent_platform.dart';
import 'package:rawg/features/dashboard/domain/entities/store.dart';

class Game {
  int? id;
  String? slug;
  String? name;
  DateTime? released;
  bool? tba;
  String? backgroundImage;
  int? ratingsCount;
  int? reviewsTextCount;
  int? added;
  int? metacritic;
  int? playtime;
  int? suggestionsCount;
  int? reviewsCount;
  String? saturatedColor;
  String? dominantColor;
  List<ParentPlatform>? parentPlatforms;
  List<Genre>? genres;
  List<Store>? stores;
  EsrbRating? esrbRating;

  Game({
    this.id,
    this.slug,
    this.name,
    this.released,
    this.tba,
    this.backgroundImage,
    this.ratingsCount,
    this.reviewsTextCount,
    this.added,
    this.metacritic,
    this.playtime,
    this.suggestionsCount,
    this.reviewsCount,
    this.saturatedColor,
    this.dominantColor,
    this.parentPlatforms,
    this.genres,
    this.stores,
    this.esrbRating,
  });

  String get platforms {
    if (parentPlatforms == null) return '';
    return parentPlatforms!.map((p) => p.platform?.name).join(', ');
  }

  String get getGenreNames {
    if (genres == null || genres!.isEmpty) {
      return 'genres.action'.tr();
    }
    return genres!.map((g) => g.name).join(', ');
  }
}