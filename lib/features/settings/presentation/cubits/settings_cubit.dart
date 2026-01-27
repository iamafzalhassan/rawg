import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/core/services/onesignal_service.dart';
import 'package:rawg/features/auth/domain/usecases/sign_out_use_case.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final OneSignalService oneSignalService;
  final SignOutUseCase signOutUseCase;

  SettingsCubit(this.oneSignalService, this.signOutUseCase) : super(const SettingsState()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final notificationsEnabled = await oneSignalService.getNotificationsEnabled();
    emit(state.copyWith(notificationsEnabled: notificationsEnabled));
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    emit(state.copyWith(notificationsEnabled: enabled));
    await oneSignalService.setNotificationsEnabled(enabled);
  }

  void setCurrentLocale(Locale locale) {
    emit(state.copyWith(currentLocale: locale));
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));

    final result = await signOutUseCase();

    switch (result) {
      case ApiSuccess():
        await oneSignalService.removeExternalUserId();

        emit(state.copyWith(isLoading: false, signedOut: true));
      case ApiFailure(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }
}