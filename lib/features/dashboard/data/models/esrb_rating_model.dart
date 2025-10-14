import 'package:rawg/features/dashboard/domain/entities/esrb_rating.dart';

class EsrbRatingModel extends EsrbRating{
  EsrbRatingModel({required super.id, required super.name, required super.slug});

  EsrbRatingModel copyWith({int? id, String? name, String? slug}) => EsrbRatingModel(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
  );

  factory EsrbRatingModel.fromJson(Map<String, dynamic> json) => EsrbRatingModel(id: json["id"], name: json["name"], slug: json["slug"]);
}