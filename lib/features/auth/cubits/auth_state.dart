part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final int currentTabIndex;

  const AuthState({this.currentTabIndex = 0});

  AuthState copyWith({int? currentTabIndex}) {
    return AuthState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  List<Object?> get props => [currentTabIndex];

  @override
  bool get stringify => true;
}