import 'package:rawg/features/dashboard/domain/entities/publisher.dart';

class GameOverview {
  int id;
  int metacritic;
  String website;
  int playtime;
  List<Publisher> publishers;
  String descriptionRaw;

  GameOverview({
    required this.id,
    required this.metacritic,
    required this.website,
    required this.playtime,
    required this.publishers,
    required this.descriptionRaw,
  });

  String get shortDescription {
    final sentences = descriptionRaw.split(RegExp(r'(?<=[.!?])\s+'));
    return sentences.length <= 5 ? descriptionRaw : '${sentences.take(5).join(' ')}...';
  }
}