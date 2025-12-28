part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isLoading;
  final bool notificationsEnabled;
  final bool signedOut;
  final String? errorMessage;
  final Locale? currentLocale;

  const SettingsState({
    this.isLoading = false,
    this.notificationsEnabled = true,
    this.signedOut = false,
    this.errorMessage,
    this.currentLocale,
  });

  SettingsState copyWith({
    bool? isLoading,
    bool? notificationsEnabled,
    bool? signedOut,
    String? errorMessage,
    Locale? currentLocale,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
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