import 'package:rawg/features/dashboard/data/models/remote/genre_model.dart';
import 'package:rawg/features/dashboard/domain/entities/store.dart';

class StoreModel extends Store{
  StoreModel({required super.id, required super.store});

  StoreModel copyWith({int? id, GenreModel? store}) => StoreModel(id: id ?? this.id, store: store ?? this.store);

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(id: json["id"], store: GenreModel.fromJson(json["store"]));
}