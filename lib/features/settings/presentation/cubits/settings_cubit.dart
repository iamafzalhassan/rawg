import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SignOutUseCase signOutUseCase;

  SettingsCubit(this.signOutUseCase) : super(const SettingsState()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;

    emit(state.copyWith(notificationsEnabled: notificationsEnabled));
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    emit(state.copyWith(notificationsEnabled: enabled));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
  }

  void setCurrentLocale(Locale locale) {
    emit(state.copyWith(currentLocale: locale));
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));

    final result = await signOutUseCase();

    switch (result) {
      case ApiSuccess():
        emit(state.copyWith(
          isLoading: false,
          signedOut: true,
        ));
      case ApiFailure(:final message):
        emit(state.copyWith(
          isLoading: false,
          errorMessage: message,
        ));
    }
  }
}