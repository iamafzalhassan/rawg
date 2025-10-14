import 'package:rawg/features/dashboard/domain/entities/parent_platform.dart';

import 'esrb_rating_model.dart';

class ParentPlatformModel extends ParentPlatform{
  ParentPlatformModel({required super.platform});

  ParentPlatformModel copyWith({EsrbRatingModel? platform}) => ParentPlatformModel(platform: platform ?? this.platform);

  factory ParentPlatformModel.fromJson(Map<String, dynamic> json) => ParentPlatformModel(platform: EsrbRatingModel.fromJson(json["platform"]));
}