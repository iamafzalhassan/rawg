import 'package:hive_flutter/adapters.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class HiveGameOverviewModel extends HiveObject {
  final int id;
  final int metacritic;
  final int playtime;

  final String descriptionRaw;
  final String website;

  final List<String> publisherNames;

  final DateTime cachedAt;

  HiveGameOverviewModel({required this.id, required this.metacritic, required this.playtime, required this.descriptionRaw, required this.website, required this.publisherNames, required this.cachedAt});

  factory HiveGameOverviewModel.fromGameOverview(GameOverview overview) => HiveGameOverviewModel(
    id: overview.id ?? 0,
    metacritic: overview.metacritic ?? 0,
    playtime: overview.playtime ?? 0,
    descriptionRaw: overview.descriptionRaw ?? '',
    website: overview.website ?? '',
    publisherNames: overview.publishers?.map((p) => p.name ?? '').toList() ?? [],
    cachedAt: DateTime.now(),
  );

  bool get isStale {
    final difference = DateTime.now().difference(cachedAt);
    return difference.inHours > 24;
  }

  GameOverview toGameOverview() => GameOverview(
    id: id,
    metacritic: metacritic,
    playtime: playtime,
    descriptionRaw: descriptionRaw,
    website: website,
    publishers: publisherNames.map((name) => Publisher(name: name)).toList(),
  );
}

class HiveGameOverviewModelAdapter extends TypeAdapter<HiveGameOverviewModel> {
  @override
  final int typeId = 1;

  @override
  HiveGameOverviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read()};

    return HiveGameOverviewModel(
      id: fields[0] as int,
      metacritic: fields[1] as int,
      playtime: fields[3] as int,
      descriptionRaw: fields[5] as String,
      website: fields[2] as String,
      publisherNames: (fields[4] as List).cast<String>(),
      cachedAt: fields[6] as DateTime,
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
  bool operator ==(Object other) => identical(this, other) || other is HiveGameOverviewModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
