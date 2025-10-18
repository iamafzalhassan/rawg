import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_game_overview_use_case.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_games_use_case.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  bool offline = false;

  final GetGamesUseCase getGamesUseCase;
  final GetGameOverviewUseCase getGameOverviewUseCase;

  StreamSubscription<InternetStatus>? connection;

  DashboardCubit(this.getGamesUseCase, this.getGameOverviewUseCase) : super(const DashboardState()) {
    initConnectionListener();
  }

  void initConnectionListener() {
    connection = InternetConnection().onStatusChange.listen((
      status,
    ) {
      final isConnected = status == InternetStatus.connected;

      if (isConnected && offline) {
        getGames(forceRefresh: true);
      }

      offline = !isConnected;
    });
  }

  Future<void> getGames({
    bool loadMore = false,
    bool forceRefresh = false,
    String? platforms,
  }) async {
    if (!forceRefresh && (state.more || state.end)) return;

    if (loadMore) {
      emit(state.copyWith(more: true, clearMessages: true));
    } else {
      emit(
        state.copyWith(
          loading: true,
          currentPage: 1,
          platforms: platforms,
          end: false,
          clearMessages: true,
        ),
      );
    }

    final page = loadMore ? state.currentPage + 1 : 1;
    final result = await getGamesUseCase(page: page, platforms: platforms ?? state.platforms);

    switch (result) {
      case ApiSuccess<List<Game>>():
        final games = loadMore ? [...(state.games ?? <Game>[]), ...result.data] : result.data;

        final reachedEnd = result.data.isEmpty || result.data.length < 20;

        emit(
          state.copyWith(
            loading: false,
            more: false,
            games: games,
            currentPage: page,
            end: reachedEnd,
            errorMessage: games.isEmpty && page == 1 ? 'No games found' : null,
            snackbarMessage: reachedEnd && loadMore && games.isNotEmpty ? 'No more games to load' : null,
          ),
        );

      case ApiFailure<List<Game>>():
        final hasExistingGames = state.games != null && state.games!.isNotEmpty;

        emit(
          state.copyWith(
            loading: false,
            more: false,
            errorMessage: hasExistingGames ? null : result.message,
            snackbarMessage: hasExistingGames ? result.message : null,
          ),
        );
    }
  }

  Future<void> getGameOverview(int id) async {
    final result = await getGameOverviewUseCase(id);

    switch (result) {
      case ApiSuccess<GameOverview>():
        emit(state.copyWith(loading: false, selectedGame: result.data));
      case ApiFailure<GameOverview>():
        emit(state.copyWith(loading: false));
    }
  }

  void clearSnackbarMessage() {
    emit(state.copyWith(snackbarMessage: null));
  }

  @override
  Future<void> close() {
    connection?.cancel();
    return super.close();
  }
}