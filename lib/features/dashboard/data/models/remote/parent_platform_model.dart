import 'package:rawg/features/dashboard/data/models/remote/esrb_rating_model.dart';
import 'package:rawg/features/dashboard/domain/entities/parent_platform.dart';

class ParentPlatformModel extends ParentPlatform{
  ParentPlatformModel({required super.platform});

  ParentPlatformModel copyWith({EsrbRatingModel? platform}) => ParentPlatformModel(platform: platform ?? this.platform);

  factory ParentPlatformModel.fromJson(Map<String, dynamic> json) => ParentPlatformModel(platform: EsrbRatingModel.fromJson(json["platform"]));
}