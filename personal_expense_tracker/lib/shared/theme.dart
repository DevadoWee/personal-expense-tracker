import 'package:flutter/material.dart';

import 'constant.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get data {
    const surface = Color(0xFFF7F7FB);
    const primary = Color(0xFF4A63E7);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: surface,
      ),
      fontFamily: AppTypography.fontFamily,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.title,
          fontWeight: AppTypography.bold,
          color: Color(0xFF262626),
          height: 1.1,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.title,
          fontWeight: AppTypography.black,
          color: Color(0xFF262626),
          height: 1.1,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.heading,
          fontWeight: AppTypography.bold,
          color: Color(0xFF262626),
          height: 1.15,
          letterSpacing: -0.2,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.subheading,
          fontWeight: AppTypography.medium,
          color: Color(0xFF262626),
          height: 1.2,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.base,
          fontWeight: AppTypography.medium,
          color: Color(0xFF8A8A8F),
          height: 1.3,
        ),
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        color: Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius),
      ),
    );
  }
}
