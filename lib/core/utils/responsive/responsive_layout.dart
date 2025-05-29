// lib/core/utils/responsive_layout.dart

import 'package:flutter/widgets.dart';
import 'device_type.dart';
import 'context_extensions.dart';

/// A helper that shows one of three widgets depending on device size.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    required this.mobile,
    Widget? tablet,
    Widget? desktop,
    super.key,
  }) : tablet = tablet ?? mobile,
       desktop = desktop ?? tablet ?? mobile;

  @override
  Widget build(BuildContext context) {
    switch (context.deviceType) {
      case DeviceType.desktop:
        return desktop;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.mobile:
        return mobile;
    }
  }
}
