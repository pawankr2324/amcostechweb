import 'package:flutter/material.dart';

/// Reusable text style tokens for headings and body text.
class AppTextStyles {
  const AppTextStyles();

  /// Large title style (e.g., page headings).
  TextStyle get titleLarge => const TextStyle(
    fontFamily: 'Lato',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  /// Medium title style (e.g., section headings).
  TextStyle get titleMedium => const TextStyle(
    fontFamily: 'Lato',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  /// Style for avatar initials (circle avatar text).
  TextStyle get avatar => const TextStyle(
    fontFamily: 'Lato',
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  /// Subtitle style (e.g., smaller headings).
  TextStyle get subtitle => const TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// Body text style.
  TextStyle get bodyMedium => const TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
