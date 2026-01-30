import 'package:flutter/widgets.dart';

import 'device_type.dart';

/// Breakpoint configuration for device type detection.
///
/// Breakpoints define the screen width thresholds for determining
/// the current device type. Supports both portrait and landscape orientations.
class AdaptiveBreakpoints {
  /// Screen width threshold for tablet (default: 600)
  /// Screens < this value are considered phones
  final double phone;

  /// Screen width threshold for desktop (default: 1024)
  /// Screens >= phone and < this value are considered tablets
  final double tablet;

  /// Screen width threshold for large desktop (default: 1440)
  /// Screens >= tablet and < this value are considered desktop
  final double desktop;

  /// Aspect ratio threshold for foldable detection (default: 1.0)
  /// Devices with aspect ratio close to 1.0 and large screens may be foldables
  final double foldableAspectRatio;

  /// Minimum width to consider for foldable detection (default: 600)
  final double foldableMinWidth;

  /// Optional breakpoints to use when device is in landscape orientation.
  /// If null, portrait breakpoints are used for both orientations.
  final AdaptiveBreakpoints? landscape;

  /// Whether to use the shortest side for breakpoint calculations.
  /// Useful for maintaining consistent layouts across orientations.
  final bool useShortestSide;

  /// Creates breakpoint configuration with custom values.
  const AdaptiveBreakpoints({
    this.phone = 600,
    this.tablet = 1024,
    this.desktop = 1440,
    this.foldableAspectRatio = 1.1,
    this.foldableMinWidth = 600,
    this.landscape,
    this.useShortestSide = false,
  });

  /// Default breakpoints matching Material Design guidelines.
  static const AdaptiveBreakpoints material = AdaptiveBreakpoints(
    phone: 600,
    tablet: 840,
    desktop: 1200,
  );

  /// Bootstrap-style breakpoints.
  static const AdaptiveBreakpoints bootstrap = AdaptiveBreakpoints(
    phone: 576,
    tablet: 768,
    desktop: 992,
  );

  /// Creates breakpoints with separate landscape configuration.
  factory AdaptiveBreakpoints.withLandscape({
    double phone = 600,
    double tablet = 1024,
    double desktop = 1440,
    required double landscapePhone,
    required double landscapeTablet,
    required double landscapeDesktop,
  }) {
    return AdaptiveBreakpoints(
      phone: phone,
      tablet: tablet,
      desktop: desktop,
      landscape: AdaptiveBreakpoints(
        phone: landscapePhone,
        tablet: landscapeTablet,
        desktop: landscapeDesktop,
      ),
    );
  }

  /// Gets the effective width for breakpoint calculations.
  double _getEffectiveWidth(double width, double height) {
    if (useShortestSide) {
      return width < height ? width : height;
    }
    return width;
  }

  /// Gets the appropriate breakpoints based on orientation.
  AdaptiveBreakpoints _getBreakpointsForOrientation(
    double width,
    double height,
  ) {
    if (landscape != null && width > height) {
      return landscape!;
    }
    return this;
  }

  /// Determines the device type based on screen width and aspect ratio.
  DeviceType getDeviceType(double width, double height) {
    final effectiveWidth = _getEffectiveWidth(width, height);
    final breakpoints = _getBreakpointsForOrientation(width, height);
    final aspectRatio = width / height;

    // Check for foldable first (square-ish aspect ratio with large width)
    if (effectiveWidth >= foldableMinWidth &&
        aspectRatio >= (1 / foldableAspectRatio) &&
        aspectRatio <= foldableAspectRatio &&
        effectiveWidth < breakpoints.tablet) {
      return DeviceType.foldable;
    }

    if (effectiveWidth < breakpoints.phone) {
      return DeviceType.phone;
    } else if (effectiveWidth < breakpoints.tablet) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Gets the current orientation.
  static Orientation getOrientation(double width, double height) {
    return width > height ? Orientation.landscape : Orientation.portrait;
  }

  @override
  String toString() {
    return 'AdaptiveBreakpoints(phone: $phone, tablet: $tablet, desktop: $desktop, landscape: $landscape)';
  }
}
