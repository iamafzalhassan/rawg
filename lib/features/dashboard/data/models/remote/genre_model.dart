import 'package:rawg/features/dashboard/domain/entities/genre.dart';

class GenreModel extends Genre {
  GenreModel({
    required super.gamesCount,
    required super.id,
    required super.imageBackground,
    required super.name,
    required super.slug,
  });

  GenreModel copyWith({
    int? gamesCount,
    int? id,
    String? imageBackground,
    String? name,
    String? slug,
  }) => GenreModel(
    gamesCount: gamesCount ?? this.gamesCount,
    id: id ?? this.id,
    imageBackground: imageBackground ?? this.imageBackground,
    name: name ?? this.name,
    slug: slug ?? this.slug,
  );

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    imageBackground: json["image_background"],
  );
}