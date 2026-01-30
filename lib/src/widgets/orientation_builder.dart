import 'package:flutter/widgets.dart';

import '../core/adaptive_data.dart';
import '../device/device_info.dart';

/// Signature for a widget builder that receives orientation context.
typedef OrientationWidgetBuilder =
    Widget Function(BuildContext context, AdaptiveDeviceInfo info);

/// A builder widget that provides different layouts for portrait and landscape.
///
/// This is useful for creating orientation-specific UIs without using
/// conditional statements throughout your code.
///
/// ```dart
/// OrientationBuilder(
///   portrait: (context, info) => PortraitLayout(),
///   landscape: (context, info) => LandscapeLayout(),
/// )
/// ```
class OrientationLayoutBuilder extends StatelessWidget {
  /// Creates an orientation layout builder.
  const OrientationLayoutBuilder({
    super.key,
    required this.portrait,
    this.landscape,
  });

  /// Widget builder for portrait orientation.
  final OrientationWidgetBuilder portrait;

  /// Widget builder for landscape orientation.
  /// Falls back to [portrait] if not provided.
  final OrientationWidgetBuilder? landscape;

  @override
  Widget build(BuildContext context) {
    final data = AdaptiveData.of(context);
    final info = data.getDeviceInfo(context);

    if (info.isLandscape && landscape != null) {
      return landscape!(context, info);
    }

    return portrait(context, info);
  }
}

/// A simpler version of [OrientationLayoutBuilder] that takes widgets directly.
///
/// ```dart
/// OrientationLayout(
///   portrait: PortraitWidget(),
///   landscape: LandscapeWidget(),
/// )
/// ```
class OrientationLayout extends StatelessWidget {
  /// Creates an orientation layout widget.
  const OrientationLayout({super.key, required this.portrait, this.landscape});

  /// Widget for portrait orientation.
  final Widget portrait;

  /// Widget for landscape orientation.
  /// Falls back to [portrait] if not provided.
  final Widget? landscape;

  @override
  Widget build(BuildContext context) {
    final data = AdaptiveData.of(context);
    final info = data.getDeviceInfo(context);

    if (info.isLandscape && landscape != null) {
      return landscape!;
    }

    return portrait;
  }
}

/// Combines device type and orientation for comprehensive layout building.
///
/// This widget allows you to provide different layouts for each combination
/// of device type and orientation.
///
/// ```dart
/// AdaptiveOrientationBuilder(
///   phonePortrait: (context, info) => PhonePortraitLayout(),
///   phoneLandscape: (context, info) => PhoneLandscapeLayout(),
///   tabletPortrait: (context, info) => TabletPortraitLayout(),
///   tabletLandscape: (context, info) => TabletLandscapeLayout(),
/// )
/// ```
class AdaptiveOrientationBuilder extends StatelessWidget {
  /// Creates an adaptive orientation builder.
  const AdaptiveOrientationBuilder({
    super.key,
    required this.phonePortrait,
    this.phoneLandscape,
    this.tabletPortrait,
    this.tabletLandscape,
    this.desktopPortrait,
    this.desktopLandscape,
    this.foldablePortrait,
    this.foldableLandscape,
  });

  /// Phone in portrait orientation (required, used as fallback).
  final OrientationWidgetBuilder phonePortrait;

  /// Phone in landscape orientation.
  final OrientationWidgetBuilder? phoneLandscape;

  /// Tablet in portrait orientation.
  final OrientationWidgetBuilder? tabletPortrait;

  /// Tablet in landscape orientation.
  final OrientationWidgetBuilder? tabletLandscape;

  /// Desktop in portrait orientation.
  final OrientationWidgetBuilder? desktopPortrait;

  /// Desktop in landscape orientation.
  final OrientationWidgetBuilder? desktopLandscape;

  /// Foldable in portrait orientation.
  final OrientationWidgetBuilder? foldablePortrait;

  /// Foldable in landscape orientation.
  final OrientationWidgetBuilder? foldableLandscape;

  @override
  Widget build(BuildContext context) {
    final data = AdaptiveData.of(context);
    final info = data.getDeviceInfo(context);
    final isLandscape = info.isLandscape;

    // Get the appropriate builder based on device type and orientation
    OrientationWidgetBuilder? builder;

    if (info.isPhone) {
      builder = isLandscape ? phoneLandscape : phonePortrait;
      builder ??= phonePortrait;
    } else if (info.isTablet) {
      builder = isLandscape ? tabletLandscape : tabletPortrait;
      builder ??= tabletPortrait ?? phonePortrait;
    } else if (info.isDesktop) {
      builder = isLandscape ? desktopLandscape : desktopPortrait;
      builder ??= desktopPortrait ?? tabletPortrait ?? phonePortrait;
    } else if (info.isFoldable) {
      builder = isLandscape ? foldableLandscape : foldablePortrait;
      builder ??= foldablePortrait ?? phonePortrait;
    } else {
      builder = phonePortrait;
    }

    return builder(context, info);
  }
}
