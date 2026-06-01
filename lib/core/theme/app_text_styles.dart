import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle heroHeading = GoogleFonts.inter(
    fontSize: 64,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    height: 1.1,
    letterSpacing: -1.5,
  );

  static TextStyle heroHeadingMobile = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    height: 1.2,
    letterSpacing: -0.8,
  );

  static TextStyle heroHeadingTablet = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    height: 1.1,
    letterSpacing: -1.2,
  );

  static TextStyle h1 = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    height: 1.2,
    letterSpacing: -1.0,
  );

  static TextStyle h1Mobile = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    height: 1.25,
    letterSpacing: -0.75,
  );

  static TextStyle h2Mobile = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    height: 1.25,
  );

  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    height: 1.3,
  );

  static TextStyle h4 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    height: 1.35,
  );

  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.6,
  );

  static TextStyle body = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.6,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.5,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.4,
  );

  static TextStyle label = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkText,
    height: 1.4,
  );

  static TextStyle buttonText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.1,
  );

  static TextStyle buttonTextSmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.0,
  );

  static TextStyle navLink = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    height: 1.0,
  );

  static TextStyle sectionBadge = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    letterSpacing: 1.0,
  );

  static TextStyle pricingPrice = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    height: 1.0,
  );

  static TextStyle statValue = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    height: 1.0,
    letterSpacing: -1.0,
  );

  static TextStyle statValueMobile = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    height: 1.0,
  );
}
