import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class PublisherModel extends Publisher {
  PublisherModel({
    required super.gamesCount,
    required super.id,
    required super.imageBackground,
    required super.name,
    required super.slug,
  });

  PublisherModel copyWith({
    int? gamesCount,
    int? id,
    String? imageBackground,
    String? name,
    String? slug,
  }) => PublisherModel(
    gamesCount: gamesCount ?? this.gamesCount,
    id: id ?? this.id,
    imageBackground: imageBackground ?? this.imageBackground,
    name: name ?? this.name,
    slug: slug ?? this.slug,
  );

  factory PublisherModel.fromJson(Map<String, dynamic> json) => PublisherModel(
    gamesCount: json["games_count"],
    id: json["id"],
    imageBackground: json["image_background"],
    name: json["name"],
    slug: json["slug"],
  );
}