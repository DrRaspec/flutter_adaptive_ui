import 'package:flutter/widgets.dart';

import '../config/device_type.dart';
import '../core/adaptive_data.dart';
import '../device/screen_size.dart';

/// A responsive value that changes based on device type or screen size.
///
/// This class provides type-safe responsive values that can be
/// configured for different device types or screen sizes.
///
/// ```dart
/// final padding = ResponsiveValue<double>(
///   context,
///   phone: 16,
///   tablet: 24,
///   desktop: 32,
/// ).value;
/// ```
class ResponsiveValue<T> {
  final BuildContext _context;
  final T? _phone;
  final T? _tablet;
  final T? _desktop;
  final T? _foldable;
  final T? _defaultValue;

  /// Creates a responsive value based on device type.
  const ResponsiveValue(
    this._context, {
    T? phone,
    T? tablet,
    T? desktop,
    T? foldable,
    T? defaultValue,
  }) : _phone = phone,
       _tablet = tablet,
       _desktop = desktop,
       _foldable = foldable,
       _defaultValue = defaultValue;

  /// Gets the value for the current device type.
  T get value {
    final data = AdaptiveData.of(_context);
    final info = data.getDeviceInfo(_context);

    switch (info.deviceType) {
      case DeviceType.phone:
        return _phone ?? _defaultValue ?? _tablet ?? _desktop as T;
      case DeviceType.tablet:
        return _tablet ?? _phone ?? _desktop ?? _defaultValue as T;
      case DeviceType.desktop:
        return _desktop ?? _tablet ?? _phone ?? _defaultValue as T;
      case DeviceType.foldable:
        return _foldable ?? _phone ?? _tablet ?? _defaultValue as T;
    }
  }
}

/// A responsive value based on screen size categories.
///
/// ```dart
/// final columns = ScreenResponsiveValue<int>(
///   context,
///   xs: 1,
///   sm: 2,
///   md: 3,
///   lg: 4,
///   xl: 6,
/// ).value;
/// ```
class ScreenResponsiveValue<T> {
  final BuildContext _context;
  final T? _xs;
  final T? _sm;
  final T? _md;
  final T? _lg;
  final T? _xl;
  final T? _defaultValue;

  /// Creates a responsive value based on screen size.
  const ScreenResponsiveValue(
    this._context, {
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? defaultValue,
  }) : _xs = xs,
       _sm = sm,
       _md = md,
       _lg = lg,
       _xl = xl,
       _defaultValue = defaultValue;

  /// Gets the value for the current screen size.
  T get value {
    final data = AdaptiveData.of(_context);
    final info = data.getDeviceInfo(_context);

    switch (info.screenSize) {
      case ScreenSize.xs:
        return _xs ?? _defaultValue ?? _sm ?? _md ?? _lg ?? _xl as T;
      case ScreenSize.sm:
        return _sm ?? _xs ?? _md ?? _lg ?? _xl ?? _defaultValue as T;
      case ScreenSize.md:
        return _md ?? _sm ?? _lg ?? _xs ?? _xl ?? _defaultValue as T;
      case ScreenSize.lg:
        return _lg ?? _md ?? _xl ?? _sm ?? _xs ?? _defaultValue as T;
      case ScreenSize.xl:
        return _xl ?? _lg ?? _md ?? _sm ?? _xs ?? _defaultValue as T;
    }
  }
}
