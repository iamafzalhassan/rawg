import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
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
  final GetGamesUseCase getGamesUseCase;
  final GetGameOverviewUseCase getGameOverviewUseCase;

  bool offline = false;
  Duration searchDebounceDuration = Duration(seconds: 1);

  Timer? timer;
  StreamSubscription<InternetStatus>? connection;

  DashboardCubit(this.getGamesUseCase, this.getGameOverviewUseCase) : super(const DashboardState()) {
    initConnectionListener();
  }

  void initConnectionListener() {
    connection = InternetConnection().onStatusChange.listen((status) {
      final isConnected = status == InternetStatus.connected;

      if (isConnected && offline) {
        getGames(forceRefresh: true);
      }

      offline = !isConnected;
    });
  }

  void onSearchChanged(String query) {
    timer?.cancel();

    emit(state.copyWith(searchQuery: query, search: query.isNotEmpty));

    if (query.isEmpty) {
      getGames(searchQuery: null);
      return;
    }

    timer = Timer(searchDebounceDuration, () => getGames(searchQuery: query));
  }

  void clearSearch() {
    timer?.cancel();
    emit(state.copyWith(searchQuery: '', search: false));
    getGames(searchQuery: null);
  }

  Future<void> getGames({
    bool loadMore = false,
    bool forceRefresh = false,
    String? platforms,
    String? searchQuery,
  }) async {
    if (!forceRefresh && loadMore && (state.more || state.end)) return;

    if (loadMore) {
      emit(state.copyWith(more: true, clearMessages: true));
    } else {
      emit(
        state.copyWith(
          loading: true,
          currentPage: 1,
          platforms: platforms,
          searchQuery: searchQuery,
          search: false,
          end: false,
          clearMessages: true,
        ),
      );
    }

    final page = loadMore ? state.currentPage + 1 : 1;
    final platformsToUse = platforms ?? state.platforms;
    final queryToUse = searchQuery ?? state.searchQuery;

    final result = await getGamesUseCase(
      page: page,
      platforms: platformsToUse,
      searchQuery: queryToUse?.isEmpty ?? true ? null : queryToUse,
    );

    handleGamesResult(result, loadMore, page);
  }

  void handleGamesResult(
      ApiResult<List<Game>> result,
      bool loadMore,
      int page,
      ) {
    switch (result) {
      case ApiSuccess<List<Game>>(:final data):
        final games = loadMore ? [...?state.games, ...data] : data;
        final reachedEnd = data.isEmpty || data.length < 20;

        emit(
          state.copyWith(
            loading: false,
            more: false,
            games: games,
            currentPage: page,
            end: reachedEnd,
            errorMessage: games.isEmpty && page == 1 ? 'dashboard.noGamesFound'.tr() : null,
          ),
        );

      case ApiFailure<List<Game>>(:final message):
        final hasExistingGames = state.games?.isNotEmpty ?? false;

        emit(
          state.copyWith(
            loading: false,
            more: false,
            errorMessage: hasExistingGames ? null : message,
          ),
        );
    }
  }

  Future<void> getGameOverview(int id) async {
    final result = await getGameOverviewUseCase(id);

    switch (result) {
      case ApiSuccess<GameOverview>(:final data):
        emit(state.copyWith(loading: false, selectedGame: data));
      case ApiFailure<GameOverview>():
        emit(state.copyWith(loading: false));
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    connection?.cancel();
    return super.close();
  }
}