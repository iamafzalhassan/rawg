part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isSignInFormValid;
  final bool isSignUpFormValid;

  final int currentTabIndex;

  final String? errorMessage;
  final String? successMessage;

  final User? user;

  const AuthState({this.isLoading = false, this.isSignInFormValid = false, this.isSignUpFormValid = false, this.currentTabIndex = 0, this.errorMessage, this.successMessage, this.user});

  AuthState copyWith({bool? isLoading, bool? isSignInFormValid, bool? isSignUpFormValid, int? currentTabIndex, String? errorMessage, String? successMessage, User? user}) => AuthState(
    isLoading: isLoading ?? this.isLoading,
    isSignInFormValid: isSignInFormValid ?? this.isSignInFormValid,
    isSignUpFormValid: isSignUpFormValid ?? this.isSignUpFormValid,
    currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    errorMessage: errorMessage,
    successMessage: successMessage,
    user: user ?? this.user,
  );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [isLoading, isSignInFormValid, isSignUpFormValid, currentTabIndex, errorMessage, successMessage, user];
}
