import 'package:flutter/widgets.dart';

import '../config/breakpoints.dart';
import '../config/design_size.dart';
import '../device/screen_size.dart';
import 'adaptive_data.dart';

/// The main wrapper widget that provides adaptive configuration to your app.
///
/// Wrap your [MaterialApp] or [CupertinoApp] with [AdaptiveScope] to enable
/// adaptive features throughout your application.
///
/// ```dart
/// AdaptiveScope(
///   designSize: const DesignSize(
///     phone: Size(375, 812),
///     tablet: Size(768, 1024),
///   ),
///   child: MaterialApp(
///     home: MyHomePage(),
///   ),
/// )
/// ```
class AdaptiveScope extends StatelessWidget {
  /// The widget tree that will have access to adaptive features.
  final Widget child;

  /// The breakpoints configuration for device type detection.
  ///
  /// If not provided, uses [AdaptiveBreakpoints] defaults:
  /// - phone: < 600
  /// - tablet: 600-1024
  /// - desktop: > 1024
  final AdaptiveBreakpoints breakpoints;

  /// The design size configuration for scaling calculations.
  ///
  /// If not provided, uses [DesignSize] defaults:
  /// - phone: 375x812 (iPhone 13 Mini)
  /// - tablet: 768x1024 (iPad)
  /// - desktop: 1440x900
  final DesignSize designSize;

  /// The screen size breakpoints for granular responsive design.
  ///
  /// If not provided, uses [ScreenSizeBreakpoints] defaults:
  /// - xs: < 360
  /// - sm: 360-600
  /// - md: 600-900
  /// - lg: 900-1200
  /// - xl: > 1200
  final ScreenSizeBreakpoints screenSizeBreakpoints;

  /// Creates an [AdaptiveScope] with the given configuration.
  ///
  /// All configuration parameters are optional and will use sensible defaults.
  const AdaptiveScope({
    super.key,
    required this.child,
    this.breakpoints = const AdaptiveBreakpoints(),
    this.designSize = const DesignSize(),
    this.screenSizeBreakpoints = const ScreenSizeBreakpoints(),
  });

  /// Creates an [AdaptiveScope] with Material Design breakpoints.
  const AdaptiveScope.material({
    super.key,
    required this.child,
    this.designSize = const DesignSize(),
    this.screenSizeBreakpoints = const ScreenSizeBreakpoints(),
  }) : breakpoints = AdaptiveBreakpoints.material;

  /// Creates an [AdaptiveScope] with Bootstrap breakpoints.
  const AdaptiveScope.bootstrap({
    super.key,
    required this.child,
    this.designSize = const DesignSize(),
    this.screenSizeBreakpoints = const ScreenSizeBreakpoints(),
  }) : breakpoints = AdaptiveBreakpoints.bootstrap;

  @override
  Widget build(BuildContext context) {
    return AdaptiveData(
      breakpoints: breakpoints,
      designSize: designSize,
      screenSizeBreakpoints: screenSizeBreakpoints,
      child: child,
    );
  }
}
