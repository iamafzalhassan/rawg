part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final bool loading;
  final bool more;
  final bool end;
  final int currentPage;
  final String? message;
  final String? platforms;
  final GameOverview? selectedGame;
  final List<Game>? games;

  const DashboardState({
    this.loading = true,
    this.more = false,
    this.end = false,
    this.currentPage = 1,
    this.message,
    this.platforms,
    this.selectedGame,
    this.games,
  });

  DashboardState copyWith({
    bool? loading,
    bool? more,
    bool? end,
    int? currentPage,
    String? message,
    String? platforms,
    GameOverview? selectedGame,
    List<Game>? games,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      more: more ?? this.more,
      end: end ?? this.end,
      currentPage: currentPage ?? this.currentPage,
      message: message ?? this.message,
      platforms: platforms ?? this.platforms,
      selectedGame: selectedGame ?? this.selectedGame,
      games: games ?? this.games,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    more,
    end,
    currentPage,
    message,
    platforms,
    selectedGame,
    games,
  ];
}