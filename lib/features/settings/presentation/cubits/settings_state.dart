part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool notificationsEnabled;
  final bool isLoading;
  final bool signedOut;
  final String? errorMessage;
  final Locale? currentLocale;

  const SettingsState({
    this.notificationsEnabled = true,
    this.isLoading = false,
    this.signedOut = false,
    this.errorMessage,
    this.currentLocale,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? isLoading,
    bool? signedOut,
    String? errorMessage,
    Locale? currentLocale,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isLoading: isLoading ?? this.isLoading,
      signedOut: signedOut ?? this.signedOut,
      errorMessage: errorMessage,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }

  @override
  List<Object?> get props => [
    notificationsEnabled,
    isLoading,
    signedOut,
    errorMessage,
    currentLocale,
  ];
}