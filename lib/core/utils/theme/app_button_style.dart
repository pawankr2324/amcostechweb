// File: lib/core/theme/app_button_style.dart

import 'package:flutter/material.dart';

import 'app_text_styles.dart';

/// A centralized place for defining all button‐related ThemeData.
/// You can import and call these methods from your AppTheme.
class AppButtonStyle {
  /// Returns an ElevatedButtonThemeData configured for either
  /// light or dark mode, depending on the provided ColorScheme.
  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        textStyle: AppTextStyles().bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        elevation: 2,
      ),
    );
  }

  /// Returns a TextButtonThemeData for either light or dark mode.
  static TextButtonThemeData textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        textStyle: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    );
  }

  /// Returns an OutlinedButtonThemeData for either light or dark mode.
  static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: colorScheme.primary, width: 2),
        foregroundColor: colorScheme.primary,
        textStyle: AppTextStyles().bodyMedium.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    );
  }
}
