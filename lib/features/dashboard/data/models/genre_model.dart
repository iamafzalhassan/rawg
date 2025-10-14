import 'package:rawg/features/dashboard/domain/entities/genre.dart';

class GenreModel extends Genre {
  GenreModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.gamesCount,
    required super.imageBackground,
  });

  GenreModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    String? imageBackground,
  }) => GenreModel(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    gamesCount: gamesCount ?? this.gamesCount,
    imageBackground: imageBackground ?? this.imageBackground,
  );

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    imageBackground: json["image_background"],
  );
}