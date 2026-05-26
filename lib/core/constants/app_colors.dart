import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFFBFA45A);
  static const Color primaryDark = Color(0xFF8B7335);
  static const Color primaryLight = Color(0xFFD4B96A);
  static const Color primaryGradientStart = Color(0xFFCFAB5A);
  static const Color primaryGradientEnd = Color(0xFF8B7335);

  // Background Colors
  static const Color background = Color(0xFF1A1A1F);
  static const Color backgroundSecondary = Color(0xFF22222A);
  static const Color backgroundCard = Color(0xFF2A2A35);
  static const Color backgroundInput = Color(0xFF2D2D38);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C0);
  static const Color textHint = Color(0xFF6B6B80);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Border Colors
  static const Color border = Color(0xFF3A3A4A);
  static const Color borderActive = Color(0xFFBFA45A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGradientStart, primaryGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, backgroundSecondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
