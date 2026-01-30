/// Device type enumeration for adaptive layouts.
enum DeviceType {
  /// Mobile phone (screen width < phone breakpoint)
  phone,

  /// Tablet device (phone breakpoint <= width < tablet breakpoint)
  tablet,

  /// Desktop/laptop (tablet breakpoint <= width < desktop breakpoint)
  desktop,

  /// Foldable device (detected by aspect ratio and size)
  foldable,
}

/// Extension methods for DeviceType
extension DeviceTypeExtension on DeviceType {
  /// Returns true if this is a mobile device (phone or foldable in phone mode)
  bool get isMobile => this == DeviceType.phone || this == DeviceType.foldable;

  /// Returns true if this is a large screen device (tablet or desktop)
  bool get isLargeScreen =>
      this == DeviceType.tablet || this == DeviceType.desktop;

  /// Returns the name as a readable string
  String get name {
    switch (this) {
      case DeviceType.phone:
        return 'Phone';
      case DeviceType.tablet:
        return 'Tablet';
      case DeviceType.desktop:
        return 'Desktop';
      case DeviceType.foldable:
        return 'Foldable';
    }
  }
}
