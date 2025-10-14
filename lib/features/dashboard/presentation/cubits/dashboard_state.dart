part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final bool loading;
  final String? message;
  final GameOverview? selectedGame;
  final List<Game>? games;

  const DashboardState({this.loading = true, this.message, this.selectedGame, this.games});

  DashboardState copyWith({bool? loading, String? message, GameOverview? selectedGame, List<Game>? games}) {
    return DashboardState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      selectedGame: selectedGame ?? this.selectedGame,
      games: games ?? this.games,
    );
  }

  @override
  List<Object?> get props => [loading, message, selectedGame, games];
}