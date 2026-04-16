import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF0F172A);
  static const Color brandBlue = Color(0xFF3B82F6);
  static const Color brandBlueLight = Color(0xFFEFF6FF);
  static const Color accentBlue = Color(0xFF60A5FA);
  static const Color success = Color(0xFF10B981);
  static const Color successBg = Color(0xFFECFDF5);
  static const Color bgMain = Color(0xFFF8FAFC);
  static const Color bgSurface = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandBlue,
        primary: AppColors.brandBlue,
        surface: AppColors.bgSurface,
        background: AppColors.bgMain,
      ),
      scaffoldBackgroundColor: AppColors.bgMain,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.bgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
