part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final int currentTabIndex;
  final bool isSignUpFormValid;
  final bool isSignInFormValid;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final User? user;

  const AuthState({
    this.currentTabIndex = 0,
    this.isSignUpFormValid = false,
    this.isSignInFormValid = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.user,
  });

  AuthState copyWith({
    int? currentTabIndex,
    bool? isSignUpFormValid,
    bool? isSignInFormValid,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    User? user,
  }) {
    return AuthState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      isSignUpFormValid: isSignUpFormValid ?? this.isSignUpFormValid,
      isSignInFormValid: isSignInFormValid ?? this.isSignInFormValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    currentTabIndex,
    isSignUpFormValid,
    isSignInFormValid,
    isLoading,
    errorMessage,
    successMessage,
    user,
  ];

  @override
  bool get stringify => true;
}