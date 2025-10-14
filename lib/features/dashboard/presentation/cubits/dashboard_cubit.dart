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

  Future<void> getGames() async {
    emit(state.copyWith(loading: true));

    final result = await getGamesUseCase();

    switch (result) {
      case ApiSuccess<List<Game>>():
        emit(state.copyWith(loading: false, games: result.data));
      case ApiFailure<List<Game>>():
        emit(state.copyWith(loading: false, message: result.message));
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