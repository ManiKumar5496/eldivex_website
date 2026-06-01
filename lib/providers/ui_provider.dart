import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navbarScrolledProvider = StateNotifierProvider<NavbarScrolledNotifier, bool>((ref) {
  return NavbarScrolledNotifier();
});

class NavbarScrolledNotifier extends StateNotifier<bool> {
  NavbarScrolledNotifier() : super(false);
  void setScrolled(bool value) => state = value;
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);
  void toggle() => state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  void setMode(ThemeMode mode) => state = mode;
}

final sidebarOpenProvider = StateNotifierProvider<SidebarOpenNotifier, bool>((ref) {
  return SidebarOpenNotifier();
});

class SidebarOpenNotifier extends StateNotifier<bool> {
  SidebarOpenNotifier() : super(true);
  void toggle() => state = !state;
  void setOpen(bool value) => state = value;
}

final pricingAnnualProvider = StateNotifierProvider<PricingAnnualNotifier, bool>((ref) {
  return PricingAnnualNotifier();
});

class PricingAnnualNotifier extends StateNotifier<bool> {
  PricingAnnualNotifier() : super(false);
  void toggle() => state = !state;
}
