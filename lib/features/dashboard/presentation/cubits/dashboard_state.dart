part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final bool loading;
  final bool more;
  final bool end;
  final int currentPage;
  final String? errorMessage;
  final String? snackbarMessage;
  final String? platforms;
  final GameOverview? selectedGame;
  final List<Game>? games;

  const DashboardState({
    this.loading = true,
    this.more = false,
    this.end = false,
    this.currentPage = 1,
    this.errorMessage,
    this.snackbarMessage,
    this.platforms,
    this.selectedGame,
    this.games,
  });

  DashboardState copyWith({
    bool? loading,
    bool? more,
    bool? end,
    int? currentPage,
    String? errorMessage,
    String? snackbarMessage,
    bool clearMessages = false,
    String? platforms,
    GameOverview? selectedGame,
    List<Game>? games,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      more: more ?? this.more,
      end: end ?? this.end,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
      snackbarMessage: clearMessages ? null : (snackbarMessage ?? this.snackbarMessage),
      platforms: platforms ?? this.platforms,
      selectedGame: selectedGame ?? this.selectedGame,
      games: games ?? this.games,
    );
  }

  bool get hasGames => games != null && games!.isNotEmpty;

  bool get showError => errorMessage != null && !hasGames;

  bool get showLoadMoreButton => !more && !end && hasGames;

  bool get showEndMessage => end && hasGames;

  @override
  List<Object?> get props => [
    loading,
    more,
    end,
    currentPage,
    errorMessage,
    snackbarMessage,
    platforms,
    selectedGame,
    games,
  ];
}