class Genre {
  int id;
  String name;
  String slug;
  int gamesCount;
  String imageBackground;
  String? domain;

  Genre({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
    this.domain,
  });
}