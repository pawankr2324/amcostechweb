// File: lib/core/utils/theme/theme_extensions.dart

import 'package:flutter/material.dart';

/// Example of a custom theme extension (e.g., for status colors).
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color success;
  final Color warning;
  final Color info;

  const CustomColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  @override
  CustomColors copyWith({Color? success, Color? warning, Color? info}) {
    return CustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }

  // Predefined light/dark variants
  static const light = CustomColors(
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFC107),
    info: Color(0xFF2196F3),
  );
  static const dark = CustomColors(
    success: Color(0xFF81C784),
    warning: Color(0xFFFFD54F),
    info: Color(0xFF90CAF9),
  );
}
