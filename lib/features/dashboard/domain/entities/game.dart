import 'package:easy_localization/easy_localization.dart';
import 'package:rawg/features/dashboard/domain/entities/esrb_rating.dart';
import 'package:rawg/features/dashboard/domain/entities/genre.dart';
import 'package:rawg/features/dashboard/domain/entities/parent_platform.dart';
import 'package:rawg/features/dashboard/domain/entities/store.dart';

class Game {
  bool? tba;
  int? added;
  int? id;
  int? metacritic;
  int? playtime;
  int? ratingsCount;
  int? reviewsCount;
  int? reviewsTextCount;
  int? suggestionsCount;
  String? backgroundImage;
  String? dominantColor;
  String? name;
  String? saturatedColor;
  String? slug;
  DateTime? released;
  EsrbRating? esrbRating;
  List<Genre>? genres;
  List<ParentPlatform>? parentPlatforms;
  List<Store>? stores;

  Game({
    this.tba,
    this.added,
    this.id,
    this.metacritic,
    this.playtime,
    this.ratingsCount,
    this.reviewsCount,
    this.reviewsTextCount,
    this.suggestionsCount,
    this.backgroundImage,
    this.dominantColor,
    this.name,
    this.saturatedColor,
    this.slug,
    this.released,
    this.esrbRating,
    this.genres,
    this.parentPlatforms,
    this.stores,
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