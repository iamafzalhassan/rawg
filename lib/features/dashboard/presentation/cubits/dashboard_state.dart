part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final bool loading;
  final bool more;
  final bool end;
  final bool search;
  final String? errorMessage;
  final String? snackbarMessage;
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
    this.snackbarMessage,
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
    String? snackbarMessage,
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
      snackbarMessage: clearMessages ? null : (snackbarMessage ?? this.snackbarMessage),
      platforms: platforms ?? this.platforms,
      searchQuery: searchQuery ?? this.searchQuery,
      search: search ?? this.search,
      currentPage: currentPage ?? this.currentPage,
      selectedGame: selectedGame ?? this.selectedGame,
      games: games ?? this.games,
    );
  }

  bool get hasGames => games?.isNotEmpty ?? false;

  bool get showError => errorMessage != null && !hasGames;

  bool get showLoadMoreButton => !more && !end && hasGames;

  bool get showEndMessage => end && hasGames;

  bool get hasSearchQuery => searchQuery?.isNotEmpty ?? false;

  @override
  List<Object?> get props => [
    loading,
    more,
    end,
    errorMessage,
    snackbarMessage,
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