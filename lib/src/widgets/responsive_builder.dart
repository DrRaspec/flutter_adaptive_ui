import 'package:flutter/widgets.dart';

import '../core/adaptive_data.dart';
import '../device/device_info.dart';
import '../device/screen_size.dart';
import '../extensions/num_ext.dart';

/// A builder widget that provides different layouts based on screen size.
///
/// Use this widget for finer-grained responsive control based on
/// screen size categories (xs, sm, md, lg, xl).
///
/// ```dart
/// ResponsiveBuilder(
///   xs: (context, info) => SingleColumnLayout(),
///   sm: (context, info) => SingleColumnLayout(),
///   md: (context, info) => TwoColumnLayout(),
///   lg: (context, info) => ThreeColumnLayout(),
///   xl: (context, info) => FourColumnLayout(),
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Builder for extra small screens (< 360px).
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? xs;

  /// Builder for small screens (360-600px).
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? sm;

  /// Builder for medium screens (600-900px).
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? md;

  /// Builder for large screens (900-1200px).
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? lg;

  /// Builder for extra large screens (> 1200px).
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? xl;

  /// Default builder used when no specific builder is provided.
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? builder;

  /// Creates a [ResponsiveBuilder] widget.
  const ResponsiveBuilder({
    super.key,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.builder,
  }) : assert(
         xs != null ||
             sm != null ||
             md != null ||
             lg != null ||
             xl != null ||
             builder != null,
         'At least one builder must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final data = AdaptiveData.of(context);
    final info = data.getDeviceInfo(context);

    // Set context for num extensions
    AdaptiveContext.setContext(context);

    Widget Function(BuildContext, AdaptiveDeviceInfo)? selectedBuilder;

    switch (info.screenSize) {
      case ScreenSize.xs:
        selectedBuilder = xs ?? builder;
        break;
      case ScreenSize.sm:
        selectedBuilder = sm ?? xs ?? builder;
        break;
      case ScreenSize.md:
        selectedBuilder = md ?? sm ?? xs ?? builder;
        break;
      case ScreenSize.lg:
        selectedBuilder = lg ?? md ?? sm ?? xs ?? builder;
        break;
      case ScreenSize.xl:
        selectedBuilder = xl ?? lg ?? md ?? sm ?? xs ?? builder;
        break;
    }

    if (selectedBuilder == null) {
      throw FlutterError(
        'ResponsiveBuilder: No builder found for screen size ${info.screenSize}.\n'
        'Provide a builder for ${info.screenSize} or a default builder.',
      );
    }

    return selectedBuilder(context, info);
  }
}

/// A simpler version of [ResponsiveBuilder] that takes widgets directly.
///
/// ```dart
/// ResponsiveLayout(
///   xs: SingleColumnLayout(),
///   md: TwoColumnLayout(),
///   xl: FourColumnLayout(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  /// Widget for extra small screens.
  final Widget? xs;

  /// Widget for small screens.
  final Widget? sm;

  /// Widget for medium screens.
  final Widget? md;

  /// Widget for large screens.
  final Widget? lg;

  /// Widget for extra large screens.
  final Widget? xl;

  /// Default widget used when no specific widget is provided.
  final Widget? child;

  /// Creates a [ResponsiveLayout] widget.
  const ResponsiveLayout({
    super.key,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.child,
  }) : assert(
         xs != null ||
             sm != null ||
             md != null ||
             lg != null ||
             xl != null ||
             child != null,
         'At least one widget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      xs: xs != null ? (_, __) => xs! : null,
      sm: sm != null ? (_, __) => sm! : null,
      md: md != null ? (_, __) => md! : null,
      lg: lg != null ? (_, __) => lg! : null,
      xl: xl != null ? (_, __) => xl! : null,
      builder: child != null ? (_, __) => child! : null,
    );
  }
}

/// A builder that rebuilds when screen size changes.
///
/// This is useful for widgets that need to react to breakpoint changes
/// but don't need the full device info.
///
/// ```dart
/// ResponsiveBreakpointBuilder(
///   builder: (context, screenSize, orientation) {
///     return Text('Screen: $screenSize, Orientation: $orientation');
///   },
/// )
/// ```
class ResponsiveBreakpointBuilder extends StatelessWidget {
  /// Builder function that receives screen size and orientation.
  final Widget Function(
    BuildContext context,
    ScreenSize screenSize,
    Orientation orientation,
  )
  builder;

  /// Creates a [ResponsiveBreakpointBuilder].
  const ResponsiveBreakpointBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final data = AdaptiveData.of(context);
    final info = data.getDeviceInfo(context);

    // Set context for num extensions
    AdaptiveContext.setContext(context);

    return builder(context, info.screenSize, info.orientation);
  }
}
