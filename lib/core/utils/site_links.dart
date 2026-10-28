import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/analytics_service.dart';

/// External destinations used by the landing page.
abstract final class SiteLinks {
  /// Admin app login page. Set at build time:
  ///   flutter build web --dart-define=APP_LOGIN_URL=http://13.233.237.76:4000/
  /// When empty, every "Log In" entry point is hidden.
  static const String appLoginUrl = String.fromEnvironment('APP_LOGIN_URL',
      defaultValue: 'http://13.233.237.76:4000/');

  static bool get hasLogin => appLoginUrl.isNotEmpty;

  static const String whatsappNumber = '917416917249';

  static const String whatsappMessage =
      'Hello! I came across Eldivex and I\'m interested in learning more about your healthcare caregiving platform. '
      'Could you please share details about the features, pricing, and how it can benefit my organization? '
      'I would love to schedule a demo at your earliest convenience. Thank you!';

  static Future<void> openLogin({String source = 'unknown'}) async {
    if (!hasLogin) return;
    AnalyticsService.instance.logCtaClick('login', source: source);
    await _open(Uri.parse(appLoginUrl), webOnlyWindowName: '_self');
  }

  static Future<void> openWhatsApp({String source = 'unknown'}) async {
    AnalyticsService.instance.logCtaClick('whatsapp', source: source);
    await _open(Uri.parse(
      'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(whatsappMessage)}',
    ));
  }

  static Future<void> _open(Uri uri, {String? webOnlyWindowName}) async {
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: webOnlyWindowName,
      );
    } catch (e) {
      debugPrint('Could not open $uri: $e');
    }
  }
}
