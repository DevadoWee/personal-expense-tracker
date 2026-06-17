import 'package:flutter/material.dart';

import 'constant.dart';
import 'palette.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get data {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Palettes.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Palettes.primary,
        primary: Palettes.primary,
        surface: Palettes.background,
      ),
      fontFamily: AppTypography.fontFamily,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.title,
          fontWeight: AppTypography.bold,
          color: Palettes.textPrimary,
          height: 1.1,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.title,
          fontWeight: AppTypography.black,
          color: Palettes.textPrimary,
          height: 1.1,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.heading,
          fontWeight: AppTypography.bold,
          color: Palettes.textPrimary,
          height: 1.15,
          letterSpacing: -0.2,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.subheading,
          fontWeight: AppTypography.medium,
          color: Palettes.textPrimary,
          height: 1.2,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.base,
          fontWeight: AppTypography.medium,
          color: Palettes.textSecondary,
          height: 1.3,
        ),
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        color: Palettes.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius),
      ),
    );
  }
}
