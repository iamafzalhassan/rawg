part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool notificationsEnabled;
  final Locale? currentLocale;

  const SettingsState({this.notificationsEnabled = true, this.currentLocale});

  SettingsState copyWith({bool? notificationsEnabled, Locale? currentLocale}) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }

  @override
  List<Object?> get props => [notificationsEnabled, currentLocale];
}