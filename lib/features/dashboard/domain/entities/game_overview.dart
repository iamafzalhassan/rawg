import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class GameOverview {
  int? id;
  int? metacritic;
  String? website;
  int? playtime;
  List<Publisher>? publishers;
  String? descriptionRaw;

  GameOverview({
    this.id,
    this.metacritic,
    this.website,
    this.playtime,
    this.publishers,
    this.descriptionRaw,
  });

  String get shortDescription {
    if (descriptionRaw == null) return '';

    final sentences = descriptionRaw!.split(RegExp(r'(?<=[.!?])\s+'));
    final limitedText = (sentences.length <= 5 ? descriptionRaw! : sentences.take(5).join(' '));
    return limitedText.replaceAll(RegExp(r'[^a-zA-Z0-9\s\.]'), '');
  }

  String get publisherNames {
    if (publishers == null) return '';
    return publishers!.map((p) => p.name).join(', ');
  }
}