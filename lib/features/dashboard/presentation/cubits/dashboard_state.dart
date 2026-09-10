part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final bool end;
  final bool loading;
  final bool more;

  final int currentPage;

  final String? errorMessage;
  final String? platforms;
  final String? searchQuery;

  final List<Game>? games;

  final GameOverview? selectedGame;

  const DashboardState({this.end = false, this.loading = true, this.more = false, this.currentPage = 1, this.errorMessage, this.platforms, this.searchQuery, this.games, this.selectedGame});

  bool get hasGames => games?.isNotEmpty ?? false;

  bool get showError => errorMessage != null && !hasGames;

  bool get showLoadMoreButton => !more && !end && hasGames;

  DashboardState copyWith({
    bool clearMessages = false,
    bool clearPlatforms = false,
    bool clearSearchQuery = false,
    bool? end,
    bool? loading,
    bool? more,
    int? currentPage,
    String? errorMessage,
    String? platforms,
    String? searchQuery,
    List<Game>? games,
    GameOverview? selectedGame,
  }) => DashboardState(
    end: end ?? this.end,
    loading: loading ?? this.loading,
    more: more ?? this.more,
    currentPage: currentPage ?? this.currentPage,
    errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
    platforms: clearPlatforms ? null : (platforms ?? this.platforms),
    searchQuery: clearSearchQuery ? null : (searchQuery ?? this.searchQuery),
    games: games ?? this.games,
    selectedGame: selectedGame,
  );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [end, loading, more, currentPage, errorMessage, platforms, searchQuery, games, selectedGame];
}
