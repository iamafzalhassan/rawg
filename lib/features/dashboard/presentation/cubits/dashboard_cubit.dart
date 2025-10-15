import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_game_overview_use_case.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_games_use_case.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetGamesUseCase getGamesUseCase;
  final GetGameOverviewUseCase getGameOverviewUseCase;

  DashboardCubit(this.getGamesUseCase, this.getGameOverviewUseCase) : super(const DashboardState());

  Future<void> getGames({
    bool loadMore = false,
    String? ordering,
    String? platforms,
  }) async {
    if (state.more || state.end) return;

    if (loadMore) {
      emit(state.copyWith(more: true));
    } else {
      emit(state.copyWith(
        loading: true,
        currentPage: 1,
        ordering: ordering,
        platforms: platforms,
      ));
    }

    final page = loadMore ? state.currentPage + 1 : 1;
    final result = await getGamesUseCase(
      page: page,
      ordering: ordering ?? state.ordering,
      platforms: platforms ?? state.platforms,
    );

    switch (result) {
      case ApiSuccess<List<Game>>():
        final games = loadMore ? [...(state.games ?? <Game>[]), ...result.data] : result.data;

        emit(
          state.copyWith(
            loading: false,
            more: false,
            games: games,
            currentPage: page,
            end: games.isEmpty || games.length < 20,
            message: null,
          ),
        );

      case ApiFailure<List<Game>>():
        emit(state.copyWith(loading: false, more: false, message: result.message));
    }
  }

  Future<void> getGameOverview(int id) async {
    emit(state.copyWith(loading: true));

    final result = await getGameOverviewUseCase(id);

    switch (result) {
      case ApiSuccess<GameOverview>():
        emit(state.copyWith(loading: false, selectedGame: result.data));
      case ApiFailure<GameOverview>():
        emit(state.copyWith(loading: false));
    }
  }
}