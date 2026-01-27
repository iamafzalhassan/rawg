part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final bool end;
  final bool loading;
  final bool more;
  final bool search;
  final int currentPage;
  final String? errorMessage;
  final String? platforms;
  final String? searchQuery;
  final GameOverview? selectedGame;
  final List<Game>? games;

  const DashboardState({
    this.end = false,
    this.loading = true,
    this.more = false,
    this.search = false,
    this.currentPage = 1,
    this.errorMessage,
    this.platforms,
    this.searchQuery,
    this.selectedGame,
    this.games,
  });

  DashboardState copyWith({
    bool clearMessages = false,
    bool? end,
    bool? loading,
    bool? more,
    bool? search,
    int? currentPage,
    String? errorMessage,
    String? platforms,
    String? searchQuery,
    GameOverview? selectedGame,
    List<Game>? games,
  }) {
    return DashboardState(
      end: end ?? this.end,
      loading: loading ?? this.loading,
      more: more ?? this.more,
      search: search ?? this.search,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
      platforms: platforms ?? this.platforms,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedGame: selectedGame,
      games: games ?? this.games,
    );
  }

  bool get hasGames => games?.isNotEmpty ?? false;

  bool get showError => errorMessage != null && !hasGames;

  bool get showLoadMoreButton => !more && !end && hasGames;

  @override
  List<Object?> get props => [
    end,
    loading,
    more,
    search,
    currentPage,
    errorMessage,
    platforms,
    searchQuery,
    selectedGame,
    games,
  ];

  @override
  bool get stringify => true;
}