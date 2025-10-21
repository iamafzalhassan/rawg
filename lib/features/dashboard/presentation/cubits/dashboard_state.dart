part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final bool loading;
  final bool more;
  final bool end;
  final bool search;
  final String? errorMessage;
  final String? platforms;
  final String? searchQuery;
  final int currentPage;
  final GameOverview? selectedGame;
  final List<Game>? games;

  const DashboardState({
    this.loading = true,
    this.more = false,
    this.end = false,
    this.search = false,
    this.errorMessage,
    this.platforms,
    this.searchQuery,
    this.currentPage = 1,
    this.selectedGame,
    this.games,
  });

  DashboardState copyWith({
    bool? loading,
    bool? more,
    bool? end,
    bool? search,
    bool clearMessages = false,
    String? errorMessage,
    String? platforms,
    String? searchQuery,
    int? currentPage,
    GameOverview? selectedGame,
    List<Game>? games,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      more: more ?? this.more,
      end: end ?? this.end,
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
      platforms: platforms ?? this.platforms,
      searchQuery: searchQuery ?? this.searchQuery,
      search: search ?? this.search,
      currentPage: currentPage ?? this.currentPage,
      selectedGame: selectedGame,
      games: games ?? this.games,
    );
  }

  bool get hasGames => games?.isNotEmpty ?? false;

  bool get showError => errorMessage != null && !hasGames;

  bool get showLoadMoreButton => !more && !end && hasGames;

  @override
  List<Object?> get props => [
    loading,
    more,
    end,
    errorMessage,
    platforms,
    searchQuery,
    search,
    currentPage,
    selectedGame,
    games,
  ];

  @override
  bool get stringify => true;
}