import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:rawg/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:rawg/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit(this.signUpUseCase, this.signInUseCase, this.getCurrentUserUseCase) : super(const AuthState()) {
    nameController.addListener(validateSignUpForm);
    emailController.addListener(validateSignUpForm);
    passwordController.addListener(validateSignUpForm);
    signInEmailController.addListener(validateSignInForm);
    signInPasswordController.addListener(validateSignInForm);
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final signInEmailController = TextEditingController();
  final signInPasswordController = TextEditingController();

  void validateSignUpForm() {
    final isValid = nameController.text.trim().isNotEmpty && emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty;

    if (state.isSignUpFormValid != isValid) {
      emit(state.copyWith(isSignUpFormValid: isValid));
    }
  }

  void validateSignInForm() {
    final isValid = signInEmailController.text.trim().isNotEmpty && signInPasswordController.text.trim().isNotEmpty;

    if (state.isSignInFormValid != isValid) {
      emit(state.copyWith(isSignInFormValid: isValid));
    }
  }

  void switchTab(int index) {
    emit(
      state.copyWith(
        currentTabIndex: index,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  Future<void> signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );

    final result = await signUpUseCase(
      email: email,
      password: password,
      name: name,
    );

    switch (result) {
      case ApiSuccess<User>():
        emit(
          state.copyWith(
            isLoading: false,
            successMessage: 'Sign up successful! Welcome!',
            user: result.data,
          ),
        );
        clearSignUpFields();
      case ApiFailure<User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  Future<void> signIn() async {
    final email = signInEmailController.text.trim();
    final password = signInPasswordController.text.trim();

    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );

    final result = await signInUseCase(email: email, password: password);

    switch (result) {
      case ApiSuccess<User>():
        emit(
          state.copyWith(
            isLoading: false,
            successMessage: 'Sign in successful!',
            user: result.data,
          ),
        );
        clearSignInFields();
      case ApiFailure<User>(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }

  void checkCurrentUser() {
    final user = getCurrentUserUseCase();
    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }

  void clearSignUpFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void clearSignInFields() {
    signInEmailController.clear();
    signInPasswordController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    signInEmailController.dispose();
    signInPasswordController.dispose();
    return super.close();
  }
}