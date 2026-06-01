import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../constants/app_constants.dart';

abstract final class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isMobile;

  static bool isTablet(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isTablet;

  static bool isDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isDesktop;

  static bool isLargerThanMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).largerThan(MOBILE);

  static double sectionPaddingH(BuildContext context) {
    if (isMobile(context)) return AppConstants.mobilePaddingH;
    if (isTablet(context)) return AppConstants.tabletPaddingH;
    return AppConstants.sectionPaddingH;
  }

  static double sectionPaddingV(BuildContext context) {
    if (isMobile(context)) return 60.0;
    if (isTablet(context)) return 80.0;
    return AppConstants.sectionPaddingV;
  }

  static double heroFontSize(BuildContext context) {
    if (isMobile(context)) return 36.0;
    if (isTablet(context)) return 48.0;
    return 64.0;
  }

  static int gridCrossAxisCount(BuildContext context, {int desktop = 4, int tablet = 2, int mobile = 1}) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
}
