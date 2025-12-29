import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rawg/core/secrets/app_secret.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OneSignalService {
  static const String notificationEnabledKey = 'notifications_enabled';

  static final OneSignalService instance = OneSignalService._internal();

  factory OneSignalService() => instance;

  OneSignalService._internal();

  bool initialized = false;

  GoRouter? router;

  Future<void> initialize({GoRouter? router}) async {
    if (initialized) return;

    this.router = router;

    try {
      OneSignal.initialize(AppSecret.oneSignalAppId);

      await OneSignal.Notifications.requestPermission(true);

      setupNotificationHandlers();

      await syncNotificationSettings();

      initialized = true;

      if (kDebugMode) {
        log('OneSignal initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        log('OneSignal initialization error: $e');
      }
    }
  }

  void setupNotificationHandlers() {
    OneSignal.Notifications.addClickListener((event) {
      if (kDebugMode) {
        log('Notification clicked: ${event.notification.additionalData}');
      }
      handleNotificationOpened(event);
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      if (kDebugMode) {
        log('Notification received in foreground');
      }
      event.notification.display();
    });
  }

  void handleNotificationOpened(OSNotificationClickEvent event) {
    final additionalData = event.notification.additionalData;

    if (additionalData != null && additionalData.containsKey('game_id')) {
      final gameId = additionalData['game_id'];

      if (kDebugMode) {
        log('Navigating to game ID: $gameId');
      }

      if (router != null) {
        router!.go('/dashboard');
      }
    } else {
      router?.go('/dashboard');
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      OneSignal.User.pushSubscription.optIn();

      if (enabled) {
        OneSignal.User.pushSubscription.optIn();
      } else {
        OneSignal.User.pushSubscription.optOut();
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(notificationEnabledKey, enabled);

      if (kDebugMode) {
        log('Notifications ${enabled ? 'enabled' : 'disabled'}');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error setting notification preference: $e');
      }
    }
  }

  Future<bool> getNotificationsEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(notificationEnabledKey) ?? true;
    } catch (e) {
      if (kDebugMode) {
        log('Error getting notification preference: $e');
      }
      return true;
    }
  }

  Future<void> syncNotificationSettings() async {
    final enabled = await getNotificationsEnabled();
    if (enabled) {
      OneSignal.User.pushSubscription.optIn();
    } else {
      OneSignal.User.pushSubscription.optOut();
    }
  }

  Future<void> setExternalUserId(String userId) async {
    try {
      await OneSignal.login(userId);
      if (kDebugMode) {
        log('External user ID set: $userId');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error setting external user ID: $e');
      }
    }
  }

  Future<void> removeExternalUserId() async {
    try {
      await OneSignal.logout();
      if (kDebugMode) {
        log('External user ID removed');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error removing external user ID: $e');
      }
    }
  }

  Future<String?> getPlayerId() async {
    try {
      return OneSignal.User.pushSubscription.id;
    } catch (e) {
      if (kDebugMode) {
        log('Error getting player ID: $e');
      }
      return null;
    }
  }

  Future<void> addTags(Map<String, String> tags) async {
    try {
      OneSignal.User.addTags(tags);
      if (kDebugMode) {
        log('Tags added: $tags');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error adding tags: $e');
      }
    }
  }

  Future<void> removeTags(List<String> tagKeys) async {
    try {
      OneSignal.User.removeTags(tagKeys);
      if (kDebugMode) {
        log('Tags removed: $tagKeys');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error removing tags: $e');
      }
    }
  }

  Future<bool> getNotificationPermissionStatus() async {
    try {
      return OneSignal.Notifications.permission;
    } catch (e) {
      if (kDebugMode) {
        log('Error getting permission status: $e');
      }
      return false;
    }
  }

  Future<void> promptForPushNotificationPermission() async {
    try {
      await OneSignal.Notifications.requestPermission(true);
    } catch (e) {
      if (kDebugMode) {
        log('Error requesting permission: $e');
      }
    }
  }
}