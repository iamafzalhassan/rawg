import 'package:hive_flutter/adapters.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class HiveGameOverviewModel extends HiveObject {
  final int id;
  final int metacritic;
  final int playtime;
  final String descriptionRaw;
  final String website;
  final DateTime cachedAt;
  final List<String> publisherNames;

  HiveGameOverviewModel({
    required this.id,
    required this.metacritic,
    required this.playtime,
    required this.descriptionRaw,
    required this.website,
    required this.cachedAt,
    required this.publisherNames,
  });

  factory HiveGameOverviewModel.fromGameOverview(GameOverview overview) {
    return HiveGameOverviewModel(
      id: overview.id ?? 0,
      metacritic: overview.metacritic ?? 0,
      playtime: overview.playtime ?? 0,
      descriptionRaw: overview.descriptionRaw ?? '',
      website: overview.website ?? '',
      cachedAt: DateTime.now(),
      publisherNames: overview.publishers?.map((p) => p.name ?? '').toList() ?? [],
    );
  }

  GameOverview toGameOverview() {
    return GameOverview(
      id: id,
      metacritic: metacritic,
      playtime: playtime,
      descriptionRaw: descriptionRaw,
      website: website,
      publishers: publisherNames.map((name) => Publisher(name: name)).toList(),
    );
  }

  bool get isStale {
    final difference = DateTime.now().difference(cachedAt);
    return difference.inHours > 24;
  }
}

class HiveGameOverviewModelAdapter extends TypeAdapter<HiveGameOverviewModel> {
  @override
  final int typeId = 1;

  @override
  HiveGameOverviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return HiveGameOverviewModel(
      id: fields[0] as int,
      metacritic: fields[1] as int,
      playtime: fields[3] as int,
      descriptionRaw: fields[5] as String,
      website: fields[2] as String,
      cachedAt: fields[6] as DateTime,
      publisherNames: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveGameOverviewModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.metacritic)
      ..writeByte(2)
      ..write(obj.website)
      ..writeByte(3)
      ..write(obj.playtime)
      ..writeByte(4)
      ..write(obj.publisherNames)
      ..writeByte(5)
      ..write(obj.descriptionRaw)
      ..writeByte(6)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGameOverviewModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}