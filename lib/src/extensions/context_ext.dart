import 'package:flutter/widgets.dart';

import '../config/device_type.dart';
import '../core/adaptive_data.dart';
import '../device/device_info.dart';
import '../device/screen_size.dart';

/// Extension methods on [BuildContext] for easy access to adaptive features.
///
/// These extensions provide a convenient way to access device info, screen
/// metrics, and responsive values from any widget.
extension AdaptiveContextExtension on BuildContext {
  // ===== Device Info =====

  /// Gets the current [AdaptiveDeviceInfo] for this context.
  ///
  /// Requires [AdaptiveScope] to be an ancestor in the widget tree.
  AdaptiveDeviceInfo get deviceInfo {
    final data = AdaptiveData.of(this);
    return data.getDeviceInfo(this);
  }

  // ===== Device Type =====

  /// Gets the current [DeviceType].
  DeviceType get deviceType => deviceInfo.deviceType;

  /// Returns true if the current device is a phone.
  bool get isPhone => deviceInfo.isPhone;

  /// Returns true if the current device is a tablet.
  bool get isTablet => deviceInfo.isTablet;

  /// Returns true if the current device is a desktop.
  bool get isDesktop => deviceInfo.isDesktop;

  /// Returns true if the current device is a foldable.
  bool get isFoldable => deviceInfo.isFoldable;

  // ===== Screen Size =====

  /// Gets the current [ScreenSize] category.
  ScreenSize get screenSize => deviceInfo.screenSize;

  /// Returns true if the screen is extra small.
  bool get isXs => screenSize == ScreenSize.xs;

  /// Returns true if the screen is small.
  bool get isSm => screenSize == ScreenSize.sm;

  /// Returns true if the screen is medium.
  bool get isMd => screenSize == ScreenSize.md;

  /// Returns true if the screen is large.
  bool get isLg => screenSize == ScreenSize.lg;

  /// Returns true if the screen is extra large.
  bool get isXl => screenSize == ScreenSize.xl;

  // ===== Screen Dimensions =====

  /// Gets the screen width in logical pixels.
  double get screenWidth => deviceInfo.screenWidth;

  /// Gets the screen height in logical pixels.
  double get screenHeight => deviceInfo.screenHeight;

  /// Gets the device pixel ratio.
  double get pixelRatio => deviceInfo.pixelRatio;

  // ===== Orientation =====

  /// Gets the current orientation.
  Orientation get orientation => deviceInfo.orientation;

  /// Returns true if the device is in portrait orientation.
  bool get isPortrait => deviceInfo.isPortrait;

  /// Returns true if the device is in landscape orientation.
  bool get isLandscape => deviceInfo.isLandscape;

  // ===== Safe Area =====

  /// Gets the status bar height (top safe area).
  double get statusBarHeight => deviceInfo.statusBarHeight;

  /// Gets the bottom bar height (bottom safe area).
  double get bottomBarHeight => deviceInfo.bottomBarHeight;

  /// Gets the full safe area padding.
  EdgeInsets get safeAreaPadding => deviceInfo.safeAreaPadding;

  // ===== Conditional Helpers =====

  /// Returns true if the screen is larger than the given device type.
  bool largerThan(DeviceType type) {
    final currentIndex = deviceType.index;
    final targetIndex = type.index;
    return currentIndex > targetIndex;
  }

  /// Returns true if the screen is smaller than the given device type.
  bool smallerThan(DeviceType type) {
    final currentIndex = deviceType.index;
    final targetIndex = type.index;
    return currentIndex < targetIndex;
  }

  /// Returns true if the screen is the same as the given device type.
  bool equals(DeviceType type) => deviceType == type;

  /// Returns true if the screen is between two device types (inclusive).
  bool between(DeviceType start, DeviceType end) {
    final currentIndex = deviceType.index;
    return currentIndex >= start.index && currentIndex <= end.index;
  }

  // ===== Responsive Values =====

  /// Gets a value based on the current device type.
  ///
  /// ```dart
  /// final padding = context.adaptive<double>(
  ///   phone: 16,
  ///   tablet: 24,
  ///   desktop: 32,
  /// );
  /// ```
  T adaptive<T>({required T phone, T? tablet, T? desktop, T? foldable}) {
    switch (deviceType) {
      case DeviceType.phone:
        return phone;
      case DeviceType.tablet:
        return tablet ?? phone;
      case DeviceType.desktop:
        return desktop ?? tablet ?? phone;
      case DeviceType.foldable:
        return foldable ?? phone;
    }
  }

  /// Gets a value based on the current screen size.
  ///
  /// ```dart
  /// final columns = context.responsive<int>(
  ///   xs: 1,
  ///   sm: 2,
  ///   md: 3,
  ///   lg: 4,
  ///   xl: 6,
  /// );
  /// ```
  T responsive<T>({required T xs, T? sm, T? md, T? lg, T? xl}) {
    switch (screenSize) {
      case ScreenSize.xs:
        return xs;
      case ScreenSize.sm:
        return sm ?? xs;
      case ScreenSize.md:
        return md ?? sm ?? xs;
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs;
    }
  }
}
