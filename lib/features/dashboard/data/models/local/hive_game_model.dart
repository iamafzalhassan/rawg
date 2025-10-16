import 'package:hive_flutter/adapters.dart';
import 'package:rawg/features/dashboard/data/models/remote/game_model.dart';

class HiveGameModel extends HiveObject {
  final int id;
  final String slug;
  final String name;
  final String released;
  final bool tba;
  final String backgroundImage;
  final int ratingsCount;
  final int metacritic;
  final int playtime;
  final String saturatedColor;
  final String dominantColor;
  final DateTime cachedAt;

  HiveGameModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.released,
    required this.tba,
    required this.backgroundImage,
    required this.ratingsCount,
    required this.metacritic,
    required this.playtime,
    required this.saturatedColor,
    required this.dominantColor,
    required this.cachedAt,
  });

  factory HiveGameModel.fromGameModel(GameModel game) {
    return HiveGameModel(
      id: game.id ?? 0,
      slug: game.slug ?? '',
      name: game.name ?? '',
      released: game.released?.toIso8601String() ?? '',
      tba: game.tba ?? false,
      backgroundImage: game.backgroundImage ?? '',
      ratingsCount: game.ratingsCount ?? 0,
      metacritic: game.metacritic ?? 0,
      playtime: game.playtime ?? 0,
      saturatedColor: game.saturatedColor ?? '0f0f0f',
      dominantColor: game.dominantColor ?? '0f0f0f',
      cachedAt: DateTime.now(),
    );
  }

  GameModel toGameModel() {
    return GameModel(
      id: id,
      slug: slug,
      name: name,
      released: DateTime.tryParse(released) ?? DateTime.now(),
      tba: tba,
      backgroundImage: backgroundImage,
      ratingsCount: ratingsCount,
      reviewsTextCount: 0,
      added: 0,
      metacritic: metacritic,
      playtime: playtime,
      suggestionsCount: 0,
      reviewsCount: 0,
      saturatedColor: saturatedColor,
      dominantColor: dominantColor,
      parentPlatforms: [],
      genres: [],
      stores: [],
      esrbRating: null,
    );
  }

  bool get isStale {
    final difference = DateTime.now().difference(cachedAt);
    return difference.inHours > 24;
  }
}

class GameHiveModelAdapter extends TypeAdapter<HiveGameModel> {
  @override
  final int typeId = 0;

  @override
  HiveGameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return HiveGameModel(
      id: fields[0] as int,
      slug: fields[1] as String,
      name: fields[2] as String,
      released: fields[3] as String,
      tba: fields[4] as bool,
      backgroundImage: fields[5] as String,
      ratingsCount: fields[6] as int,
      metacritic: fields[7] as int,
      playtime: fields[8] as int,
      saturatedColor: fields[9] as String,
      dominantColor: fields[10] as String,
      cachedAt: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGameModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.released)
      ..writeByte(4)
      ..write(obj.tba)
      ..writeByte(5)
      ..write(obj.backgroundImage)
      ..writeByte(6)
      ..write(obj.ratingsCount)
      ..writeByte(7)
      ..write(obj.metacritic)
      ..writeByte(8)
      ..write(obj.playtime)
      ..writeByte(9)
      ..write(obj.saturatedColor)
      ..writeByte(10)
      ..write(obj.dominantColor)
      ..writeByte(11)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GameHiveModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}