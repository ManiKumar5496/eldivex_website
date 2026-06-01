import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF1D4ED8);
  static const Color accent = Color(0xFF06B6D4);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color background = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);
  static const Color darkSectionBg = Color(0xFF0F172A);
  static const Color darkSectionCard = Color(0xFF1E293B);
  static const Color navbarBg = Color(0xFFFFFFFF);
  static const Color gradientStart = Color(0xFF2563EB);
  static const Color gradientEnd = Color(0xFF06B6D4);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF1E40AF), Color(0xFF0891B2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFEFF6FF), Color(0xFFECFEFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
