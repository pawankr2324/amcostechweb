// File: lib/core/theme/app_theme.dart

import 'package:amcostechweb/core/utils/theme/app_button_style.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_theme_extensions.dart';

class AppTheme {
  /// Expose a singleton‐like accessor for AppColors
  static AppColors get colors => AppColors();

  /// Expose a singleton‐like accessor for AppTextStyles
  static AppTextStyles get textStyles => AppTextStyles();

  /// Light Theme
  static ThemeData get lightTheme {
    // Build a ColorScheme starting from the light defaults
    final ColorScheme colorScheme = ColorScheme.light().copyWith(
      primary: AppColors().primary,
      onPrimary: AppColors().onPrimary,
      secondary: AppColors().secondary,
      onSecondary: AppColors().onSecondary,
      surface: AppColors().surface,
      onSurface: AppColors().onSurface,
      error: Colors.red,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: 'Lato',

      // ----------------------------
      // AppBar Theme (Light)
      // ----------------------------
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        titleTextStyle: AppTextStyles().titleLarge.copyWith(
          color: colorScheme.onPrimary,
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),

      // ----------------------------
      // Text Theme (Light)
      // ----------------------------
      textTheme: TextTheme(
        titleLarge: AppTextStyles().titleLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        titleMedium: AppTextStyles().titleMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        bodyLarge: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        bodyMedium: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface.withAlpha(179), // ~70% opacity
        ),
      ),

      // ----------------------------
      // ElevatedButton Theme (Light)
      // ----------------------------
      elevatedButtonTheme: AppButtonStyle.elevatedButtonTheme(colorScheme),
      // ----------------------------
      // TextButton Theme (Light)
      // ----------------------------
      textButtonTheme: AppButtonStyle.textButtonTheme(colorScheme),

      // ----------------------------
      // OutlinedButton Theme (Light)
      // ----------------------------
      outlinedButtonTheme: AppButtonStyle.outlinedButtonTheme(colorScheme),

      // ----------------------------
      // InputDecoration Theme (Light)
      // ----------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        labelStyle: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        hintStyle: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface.withAlpha(153), // ~60% opacity
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
      ),

      // ----------------------------
      // Custom Theme Extensions (Light)
      // ----------------------------
      extensions: <ThemeExtension<dynamic>>[CustomColors.light],
    );
  }

  /// Dark Theme
  static ThemeData get darkTheme {
    // Build a ColorScheme starting from the dark defaults
    final ColorScheme colorScheme = ColorScheme.dark().copyWith(
      primary: AppColors().primaryDark,
      onPrimary: AppColors().onPrimaryDark,
      secondary: AppColors().secondaryDark,
      onSecondary: AppColors().onSecondaryDark,
      surface: AppColors().surfaceDark,
      onSurface: AppColors().onSurfaceDark,
      error: Colors.red.shade400,
      onError: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: 'Lato',

      // ----------------------------
      // AppBar Theme (Dark)
      // ----------------------------
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        titleTextStyle: AppTextStyles().titleLarge.copyWith(
          color: colorScheme.onPrimary,
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),

      // ----------------------------
      // Text Theme (Dark)
      // ----------------------------
      textTheme: TextTheme(
        titleLarge: AppTextStyles().titleLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        titleMedium: AppTextStyles().titleMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        bodyLarge: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        bodyMedium: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface.withAlpha(153), // ~60% opacity
        ),
      ),

      // ----------------------------
      // ElevatedButton Theme (Dark)
      // ----------------------------
      elevatedButtonTheme: AppButtonStyle.elevatedButtonTheme(colorScheme),

      // ----------------------------
      // TextButton Theme (Dark)
      // ----------------------------
      textButtonTheme: AppButtonStyle.textButtonTheme(colorScheme),

      // ----------------------------
      // OutlinedButton Theme (Dark)
      // ----------------------------
      outlinedButtonTheme: AppButtonStyle.outlinedButtonTheme(colorScheme),

      // ----------------------------
      // InputDecoration Theme (Dark)
      // ----------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        labelStyle: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        hintStyle: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.onSurface.withAlpha(153), // ~60% opacity
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
      ),

      // ----------------------------
      // Custom Theme Extensions (Dark)
      // ----------------------------
      extensions: <ThemeExtension<dynamic>>[CustomColors.dark],
    );
  }
}
