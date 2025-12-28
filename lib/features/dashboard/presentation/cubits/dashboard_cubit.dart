import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/domain/entities/game_overview.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_game_overview_use_case.dart';
import 'package:rawg/features/dashboard/domain/usecases/get_games_use_case.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetGameOverviewUseCase getGameOverviewUseCase;
  final GetGamesUseCase getGamesUseCase;

  bool offline = false;
  Duration duration = Duration(seconds: 1);
  TextEditingController textEditingController = TextEditingController();

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

  Future<void> getGames({
    bool forceRefresh = false,
    bool loadMore = false,
    String? platforms,
    String? searchQuery,
  }) async {
    if (!forceRefresh && loadMore && (state.more || state.end)) return;

    if (loadMore) {
      emit(state.copyWith(more: true, clearMessages: true));
    } else {
      emit(
        state.copyWith(
          end: false,
          loading: true,
          search: false,
          clearMessages: true,
          currentPage: 1,
          platforms: platforms,
          searchQuery: searchQuery,
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

    switch (result) {
      case ApiSuccess<List<Game>>(:final data):
        final games = loadMore ? [...?state.games, ...data] : data;

        emit(
          state.copyWith(
            end: data.isEmpty,
            loading: false,
            more: false,
            currentPage: page,
            errorMessage: games.isEmpty && page == 1 ? 'dashboard.noGamesFound'.tr() : null,
            games: games,
          ),
        );

      case ApiFailure<List<Game>>(:final message):
        emit(
          state.copyWith(
            loading: false,
            more: false,
            errorMessage: (state.games?.isNotEmpty ?? false) ? null : message,
          ),
        );
    }
  }

  Future<void> getGameOverview(int id) async {
    final result = await getGameOverviewUseCase(id);

    switch (result) {
      case ApiSuccess<GameOverview>(:final data):
        emit(
          state.copyWith(
            loading: false,
            errorMessage: null,
            selectedGame: data,
          ),
        );
      case ApiFailure<GameOverview>(:final message):
        emit(
          state.copyWith(
            loading: false,
            errorMessage: message,
            selectedGame: null,
          ),
        );
    }
  }

  void onSearchChanged(String query) {
    timer?.cancel();

    emit(state.copyWith(search: query.isNotEmpty, searchQuery: query));

    if (query.isEmpty) {
      getGames(searchQuery: null);
      return;
    }

    timer = Timer(duration, () => getGames(searchQuery: query));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    connection?.cancel();
    textEditingController.dispose();
    return super.close();
  }
}