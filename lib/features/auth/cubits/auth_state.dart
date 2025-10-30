part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final int currentTabIndex;
  final bool isSignUpFormValid;
  final bool isSignInFormValid;

  const AuthState({
    this.currentTabIndex = 0,
    this.isSignUpFormValid = false,
    this.isSignInFormValid = false,
  });

  AuthState copyWith({
    int? currentTabIndex,
    bool? isSignUpFormValid,
    bool? isSignInFormValid,
  }) {
    return AuthState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      isSignUpFormValid: isSignUpFormValid ?? this.isSignUpFormValid,
      isSignInFormValid: isSignInFormValid ?? this.isSignInFormValid,
    );
  }

  @override
  List<Object?> get props => [
    currentTabIndex,
    isSignUpFormValid,
    isSignInFormValid,
  ];

  @override
  bool get stringify => true;
}