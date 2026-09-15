import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/di/injection_container.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/core/services/onesignal_service.dart';
import 'package:rawg/features/auth/domain/entities/app_user.dart';
import 'package:rawg/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:rawg/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:rawg/features/auth/domain/usecases/sign_up_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;

  final SignInUseCase signInUseCase;

  final SignUpUseCase signUpUseCase;

  AuthCubit(this.signUpUseCase, this.signInUseCase, this.getCurrentUserUseCase) : super(const AuthState());

  void validateSignUpForm({required String email, required String name, required String password}) {
    final isValid = name.trim().isNotEmpty && email.trim().isNotEmpty && password.trim().isNotEmpty;

    if (state.isSignUpFormValid != isValid) {
      emit(state.copyWith(isSignUpFormValid: isValid));
    }
  }

  void validateSignInForm({required String email, required String password}) {
    final isValid = email.trim().isNotEmpty && password.trim().isNotEmpty;

    if (state.isSignInFormValid != isValid) {
      emit(state.copyWith(isSignInFormValid: isValid));
    }
  }

  void checkCurrentUser() {
    final user = getCurrentUserUseCase();
    if (user != null) {
      emit(state.copyWith(user: user));
      setOneSignalUserId(user.id);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, successMessage: null));

    final result = await signInUseCase(email: email.trim(), password: password.trim());

    switch (result) {
      case ApiSuccess<AppUser>():
        await setOneSignalUserId(result.data.id);

        emit(state.copyWith(isLoading: false, successMessage: 'Sign in successful!', user: result.data));
      case ApiFailure<AppUser>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> signUp({required String email, required String name, required String password}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, successMessage: null));

    final result = await signUpUseCase(email: email.trim(), name: name.trim(), password: password.trim());

    switch (result) {
      case ApiSuccess<AppUser>():
        await setOneSignalUserId(result.data.id);

        emit(state.copyWith(isLoading: false, successMessage: 'Sign up successful!', user: result.data));
      case ApiFailure<AppUser>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> setOneSignalUserId(String userId) async {
    try {
      final oneSignalService = sl<OneSignalService>();
      await oneSignalService.setExternalUserId(userId);
    } catch (e) {
      debugPrint('Failed to set OneSignal user ID: $e');
    }
  }

  void switchTab(int index) => emit(state.copyWith(currentTabIndex: index, errorMessage: null, successMessage: null));
}
