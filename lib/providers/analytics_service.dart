import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  // Analytics Events
  static Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  static Future<void> logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  static Future<void> logScreenView(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }

  static Future<void> logGamePlayed(String gameId, String gameName) async {
    await _analytics.logEvent(
      name: 'game_played',
      parameters: {
        'game_id': gameId,
        'game_name': gameName,
      },
    );
  }

  static Future<void> logTransaction(double amount, String type) async {
    await _analytics.logEvent(
      name: 'transaction',
      parameters: {
        'amount': amount,
        'type': type,
      },
    );
  }

  // Crashlytics
  static Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  static Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  static Future<void> recordNonFatalError(dynamic exception, StackTrace stack) async {
    await _crashlytics.recordError(exception, stack, reason: 'non-fatal error');
  }

  static Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  // For testing Crashlytics (remove in production)
  static Future<void> testCrash() async {
    // This will force a crash to test Crashlytics is working
    // await _crashlytics.crash();
  }

  // User Properties
  static Future<void> setUserProperty(String name, String? value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }
}