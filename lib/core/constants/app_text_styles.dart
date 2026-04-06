import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static final TextStyle onboardingTitle = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle onboardingTitleBold = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle onboardingSubtitle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSubtitle,
    height: 1.375,
  );

  static final TextStyle disclaimer = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisclaimer,
    height: 1.36,
  );

  static final TextStyle onboarding1Title = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.18,
    letterSpacing: -1,
  );

  static final TextStyle onboarding1TitleBold = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.18,
    letterSpacing: -1,
  );

  static final TextStyle buttonText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle paywallBrand = GoogleFonts.roboto(
    fontSize: 27,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static final TextStyle paywallBrandLight = GoogleFonts.roboto(
    fontSize: 27,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );

  static final TextStyle paywallSubtitle = GoogleFonts.roboto(
    fontSize: 17,
    fontWeight: FontWeight.w300,
    color: Color(0xB3FFFFFF),
    height: 1.41,
    letterSpacing: 0.38,
  );

  static final TextStyle paywallFeatureTitle = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 1.2,
    letterSpacing: 0.38,
  );

  static final TextStyle paywallFeatureSubtitle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color(0xB3FFFFFF),
    height: 1.38,
    letterSpacing: -0.08,
  );

  static final TextStyle paywallPlanLabel = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final TextStyle paywallPlanLabelDim = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
  );

  static final TextStyle paywallFinePrint = GoogleFonts.roboto(
    fontSize: 9,
    fontWeight: FontWeight.w300,
    color: Color(0x85FFFFFF),
    height: 1.32,
  );

  static final TextStyle paywallTerms = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Color(0x80FFFFFF),
  );

  static final TextStyle greetingSmall = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle greetingLarge = GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.167,
  );

  static final TextStyle categoryTitle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle questionTitle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.3,
  );

  static final TextStyle questionSubtitle = GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Color(0xCCFFFFFF),
  );

  static final TextStyle navLabel = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.24,
  );

  static final TextStyle heading1 = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static final TextStyle heading2 = GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static final TextStyle body = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static final TextStyle bodySmall = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle caption = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}
