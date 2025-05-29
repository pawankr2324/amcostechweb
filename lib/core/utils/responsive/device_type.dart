// lib/core/utils/device_type.dart

enum DeviceType { mobile, tablet, desktop }

/// Returns the [DeviceType] for the given screen width.
DeviceType getDeviceType(double width) {
  if (width >= 1024) return DeviceType.desktop;
  if (width >= 600) return DeviceType.tablet;
  return DeviceType.mobile;
}
