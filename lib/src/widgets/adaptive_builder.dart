import 'package:flutter/widgets.dart';

import '../config/device_type.dart';
import '../core/adaptive_data.dart';
import '../device/device_info.dart';
import '../extensions/num_ext.dart';

/// A builder widget that provides different layouts based on device type.
///
/// Use this widget when you need completely different layouts for
/// phone, tablet, desktop, or foldable devices.
///
/// ```dart
/// AdaptiveBuilder(
///   phone: (context, info) => PhoneLayout(),
///   tablet: (context, info) => TabletLayout(),
///   desktop: (context, info) => DesktopLayout(),
/// )
/// ```
class AdaptiveBuilder extends StatelessWidget {
  /// Builder for phone layouts.
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? phone;

  /// Builder for tablet layouts.
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? tablet;

  /// Builder for desktop layouts.
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? desktop;

  /// Builder for foldable device layouts.
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)?
  foldable;

  /// Default builder used when no specific builder is provided.
  final Widget Function(BuildContext context, AdaptiveDeviceInfo info)? builder;

  /// Creates an [AdaptiveBuilder] widget.
  ///
  /// At least one of [phone], [tablet], [desktop], [foldable], or [builder]
  /// must be provided.
  const AdaptiveBuilder({
    super.key,
    this.phone,
    this.tablet,
    this.desktop,
    this.foldable,
    this.builder,
  }) : assert(
         phone != null ||
             tablet != null ||
             desktop != null ||
             foldable != null ||
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

    switch (info.deviceType) {
      case DeviceType.phone:
        selectedBuilder = phone ?? builder;
        break;
      case DeviceType.tablet:
        selectedBuilder = tablet ?? phone ?? builder;
        break;
      case DeviceType.desktop:
        selectedBuilder = desktop ?? tablet ?? phone ?? builder;
        break;
      case DeviceType.foldable:
        selectedBuilder = foldable ?? phone ?? builder;
        break;
    }

    if (selectedBuilder == null) {
      throw FlutterError(
        'AdaptiveBuilder: No builder found for device type ${info.deviceType}.\n'
        'Provide a builder for ${info.deviceType} or a default builder.',
      );
    }

    return selectedBuilder(context, info);
  }
}

/// A simpler version of [AdaptiveBuilder] that takes widgets directly.
///
/// Use this when you have static widgets that don't need device info.
///
/// ```dart
/// AdaptiveLayout(
///   phone: PhoneLayout(),
///   tablet: TabletLayout(),
///   desktop: DesktopLayout(),
/// )
/// ```
class AdaptiveLayout extends StatelessWidget {
  /// Widget for phone layouts.
  final Widget? phone;

  /// Widget for tablet layouts.
  final Widget? tablet;

  /// Widget for desktop layouts.
  final Widget? desktop;

  /// Widget for foldable device layouts.
  final Widget? foldable;

  /// Default widget used when no specific widget is provided.
  final Widget? child;

  /// Creates an [AdaptiveLayout] widget.
  const AdaptiveLayout({
    super.key,
    this.phone,
    this.tablet,
    this.desktop,
    this.foldable,
    this.child,
  }) : assert(
         phone != null ||
             tablet != null ||
             desktop != null ||
             foldable != null ||
             child != null,
         'At least one widget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      phone: phone != null ? (_, __) => phone! : null,
      tablet: tablet != null ? (_, __) => tablet! : null,
      desktop: desktop != null ? (_, __) => desktop! : null,
      foldable: foldable != null ? (_, __) => foldable! : null,
      builder: child != null ? (_, __) => child! : null,
    );
  }
}
