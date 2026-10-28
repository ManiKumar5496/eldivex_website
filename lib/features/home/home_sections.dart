import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

/// Scroll targets on the home page. The keys are attached in [HomeScreen]
/// and used by the navbar, footer and in-page CTAs.
abstract final class HomeSections {
  static final GlobalKey features = GlobalKey(debugLabel: 'features');
  static final GlobalKey solutions = GlobalKey(debugLabel: 'solutions');
  static final GlobalKey pricing = GlobalKey(debugLabel: 'pricing');
  static final GlobalKey security = GlobalKey(debugLabel: 'security');
  static final GlobalKey contact = GlobalKey(debugLabel: 'contact');

  static Future<void> scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: AppConstants.scrollAnimationDuration,
      curve: Curves.easeInOutCubic,
    );
  }
}
