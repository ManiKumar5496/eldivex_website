import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  AnalyticsService();

  static final AnalyticsService instance = AnalyticsService();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Analytics must never break the page (e.g. blocked by an ad blocker).
  Future<void> _safe(Future<void> Function() call) async {
    try {
      await call();
    } catch (e) {
      debugPrint('Analytics error: $e');
    }
  }

  Future<void> logScreenView(String screenName) =>
      _safe(() => _analytics.logScreenView(screenName: screenName));

  Future<void> logDemoRequested({String? teamSize}) =>
      _safe(() => _analytics.logEvent(
            name: 'demo_requested',
            parameters: {
              if (teamSize != null && teamSize.isNotEmpty) 'team_size': teamSize,
            },
          ));

  /// A call-to-action click. [cta] names the action (book_demo, login,
  /// whatsapp, nav_pricing, ...); [source] names where it was clicked.
  Future<void> logCtaClick(String cta, {String source = 'unknown'}) =>
      _safe(() => _analytics.logEvent(
            name: 'cta_click',
            parameters: {'cta': cta, 'source': source},
          ));
}
