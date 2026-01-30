import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

/// Target platform for responsive design.
enum ResponsivePlatform {
  /// Web browser
  web,

  /// iOS device
  iOS,

  /// Android device
  android,

  /// macOS desktop
  macOS,

  /// Windows desktop
  windows,

  /// Linux desktop
  linux,

  /// Fuchsia OS
  fuchsia,
}

/// Utilities for platform detection.
class PlatformUtils {
  PlatformUtils._();

  /// Gets the current platform.
  static ResponsivePlatform get currentPlatform {
    if (kIsWeb) return ResponsivePlatform.web;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ResponsivePlatform.iOS;
      case TargetPlatform.android:
        return ResponsivePlatform.android;
      case TargetPlatform.macOS:
        return ResponsivePlatform.macOS;
      case TargetPlatform.windows:
        return ResponsivePlatform.windows;
      case TargetPlatform.linux:
        return ResponsivePlatform.linux;
      case TargetPlatform.fuchsia:
        return ResponsivePlatform.fuchsia;
    }
  }

  /// Returns true if running on web.
  static bool get isWeb => kIsWeb;

  /// Returns true if running on a mobile platform (iOS or Android).
  static bool get isMobile =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  /// Returns true if running on a desktop platform.
  static bool get isDesktop =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux);

  /// Returns true if running on iOS.
  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Returns true if running on Android.
  static bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Returns true if running on macOS.
  static bool get isMacOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  /// Returns true if running on Windows.
  static bool get isWindows =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  /// Returns true if running on Linux.
  static bool get isLinux =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  /// Platforms that typically use landscape orientation.
  static const List<ResponsivePlatform> landscapePlatforms = [
    ResponsivePlatform.iOS,
    ResponsivePlatform.android,
    ResponsivePlatform.fuchsia,
  ];

  /// Returns true if the current platform typically supports landscape.
  static bool get supportsLandscape =>
      landscapePlatforms.contains(currentPlatform);
}
