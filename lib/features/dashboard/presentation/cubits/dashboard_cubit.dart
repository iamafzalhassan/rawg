import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/core/network/connection_checker.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/entities/game_page.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_game_overview_use_case.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_games_use_case.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  static const Duration searchDebounce = Duration(seconds: 1);

  final ConnectionChecker connectionChecker;

  final GetGameOverviewUseCase getGameOverviewUseCase;

  final GetGamesUseCase getGamesUseCase;

  bool offline = false;

  int requestId = 0;

  StreamSubscription<bool>? connection;

  Timer? timer;

  DashboardCubit(this.getGamesUseCase, this.getGameOverviewUseCase, this.connectionChecker) : super(const DashboardState()) {
    initConnectionListener();
  }

  void initConnectionListener() {
    connection = connectionChecker.onStatusChange.listen((isConnected) {
      final wasOffline = offline;

      offline = !isConnected;

      if (isConnected && wasOffline && !state.hasGames) {
        getGames();
      }
    });
  }

  Future<void> getGameOverview(int id) async {
    final result = await getGameOverviewUseCase(id);

    switch (result) {
      case ApiSuccess<GameOverview>(:final data):
        emit(state.copyWith(clearMessages: true, selectedGame: data));
      case ApiFailure<GameOverview>(:final message):
        emit(state.copyWith(errorMessage: message, selectedGame: null));
    }
  }

  Future<void> loadInitial() async {
    if (requestId != 0) return;

    await getGames();
  }

  void onSearchChanged(String query) {
    timer?.cancel();

    if (query.isEmpty) {
      getGames(clearSearchQuery: true);
      return;
    }

    timer = Timer(searchDebounce, () => getGames(searchQuery: query));
  }

  Future<void> getGames({bool clearPlatforms = false, bool clearSearchQuery = false, bool loadMore = false, String? platforms, String? searchQuery}) async {
    if (loadMore && (state.more || state.end)) return;

    final id = ++requestId;

    if (loadMore) {
      emit(state.copyWith(clearMessages: true, more: true));
    } else {
      emit(state.copyWith(clearMessages: true, clearPlatforms: clearPlatforms, clearSearchQuery: clearSearchQuery, end: false, loading: true, currentPage: 1, platforms: platforms, searchQuery: searchQuery));
    }

    final page = loadMore ? state.currentPage + 1 : 1;
    final platformsToUse = clearPlatforms ? null : (platforms ?? state.platforms);
    final queryToUse = clearSearchQuery ? null : (searchQuery ?? state.searchQuery);

    final result = await getGamesUseCase(page: page, platforms: platformsToUse, searchQuery: queryToUse?.isEmpty ?? true ? null : queryToUse);

    if (id != requestId) return;

    switch (result) {
      case ApiSuccess<GamePage>(:final data):
        final games = loadMore ? [...?state.games, ...data.games] : data.games;

        if (games.isEmpty) {
          emit(state.copyWith(end: !data.hasMore, loading: false, more: false, currentPage: data.page, errorMessage: 'dashboard.noGamesFound'.tr(), games: games));
          return;
        }

        emit(state.copyWith(clearMessages: true, end: !data.hasMore, loading: false, more: false, currentPage: data.page, games: games));

      case ApiFailure<GamePage>(:final message):
        emit(state.copyWith(loading: false, more: false, errorMessage: message));
    }
  }

  @override
  Future<void> close() {
    connection?.cancel();
    timer?.cancel();
    return super.close();
  }
}
