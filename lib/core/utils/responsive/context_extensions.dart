// lib/core/utils/context_extensions.dart

import 'package:flutter/widgets.dart';
import 'device_type.dart';

extension ResponsiveContext on BuildContext {
  DeviceType get deviceType => getDeviceType(MediaQuery.of(this).size.width);

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;
}
