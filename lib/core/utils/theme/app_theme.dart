// File: lib/core/utils/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_theme_extensions.dart';

/// Aggregates ThemeData, color, and typography tokens for easy access.
class AppTheme {
  AppTheme._();

  /// Access your color palette (const is fine here because AppColors has a const ctor).
  static const AppColors colors = AppColors();

  /// Access your text styles as a singleton instance.
  /// Changed to `final` so it doesn’t require a const expression at compile time.
  static final AppTextStyles textStyles = AppTextStyles();

  /// Light theme, seeded from [colors.primary].
  static ThemeData get lightTheme {
    final seed = colors.primary;
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ).copyWith(
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      // … other overrides if needed
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: TextTheme(
        titleLarge: textStyles.titleLarge,
        titleMedium: textStyles.titleMedium,
        bodyMedium: textStyles.bodyMedium,
      ),
      extensions: <ThemeExtension<dynamic>>[CustomColors.light],
    );
  }

  /// Dark theme, seeded from [colors.primaryDark].
  static ThemeData get darkTheme {
    final seed = colors.primaryDark;
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ).copyWith(
      primary: colors.primaryDark,
      onPrimary: colors.onPrimaryDark,
      // … other overrides if needed
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: TextTheme(
        titleLarge: textStyles.titleLarge,
        titleMedium: textStyles.titleMedium,
        bodyMedium: textStyles.bodyMedium,
      ),
      extensions: <ThemeExtension<dynamic>>[CustomColors.dark],
    );
  }
}
