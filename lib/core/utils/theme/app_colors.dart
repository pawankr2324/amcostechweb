// File: lib/core/utils/theme/app_colors.dart

import 'package:flutter/material.dart';

/// Centralized color definitions for the app’s light & dark themes.
class AppColors {
  const AppColors();

  // Primary palette
  Color get primary => const Color(0xFF0D47A1);
  Color get onPrimary => const Color(0xFFFFFFFF);
  Color get secondary => const Color(0xFF1976D2);
  Color get onSecondary => const Color(0xFFFFFFFF);

  // Accent alias (points at secondary)
  Color get accent => secondary;
  Color get onAccent => onSecondary;

  // Surfaces
  Color get surface => const Color(0xFFF5F5F5);
  Color get onSurface => const Color(0xFF000000);

  // Dark-mode variants (if you need to override)
  Color get primaryDark => const Color(0xFF82B1FF);
  Color get onPrimaryDark => const Color(0xFF0D47A1);
  Color get secondaryDark => const Color(0xFF64B5F6);
  Color get onSecondaryDark => const Color(0xFF0D47A1);
  Color get surfaceDark => const Color(0xFF121212);
  Color get onSurfaceDark => const Color(0xFFFFFFFF);
}
