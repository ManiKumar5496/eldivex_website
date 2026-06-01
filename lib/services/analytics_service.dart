import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logScreenView(String screenName) =>
      _analytics.logScreenView(screenName: screenName);

  Future<void> logLogin(String method) =>
      _analytics.logLogin(loginMethod: method);

  Future<void> logSignUp(String method) =>
      _analytics.logSignUp(signUpMethod: method);

  Future<void> logDemoRequested() =>
      _analytics.logEvent(name: 'demo_requested');

  Future<void> logBookingCreated() =>
      _analytics.logEvent(name: 'booking_created');

  Future<void> setUserId(String userId) =>
      _analytics.setUserId(id: userId);

  Future<void> setUserProperties({required String role, required String agencyId}) async {
    await _analytics.setUserProperty(name: 'user_role', value: role);
    await _analytics.setUserProperty(name: 'agency_id', value: agencyId);
  }
}
