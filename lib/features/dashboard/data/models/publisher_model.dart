import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class PublisherModel extends Publisher {
  PublisherModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.gamesCount,
    required super.imageBackground,
  });

  PublisherModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    String? imageBackground,
  }) => PublisherModel(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    gamesCount: gamesCount ?? this.gamesCount,
    imageBackground: imageBackground ?? this.imageBackground,
  );

  factory PublisherModel.fromJson(Map<String, dynamic> json) => PublisherModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    imageBackground: json["image_background"],
  );
}