import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final signInEmailController = TextEditingController();
  final signInPasswordController = TextEditingController();

  void switchTab(int index) {
    emit(state.copyWith(currentTabIndex: index));
  }

  void signUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
  }

  void signIn() {
    final email = signInEmailController.text.trim();
    final password = signInPasswordController.text.trim();
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