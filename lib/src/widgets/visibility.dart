import 'package:flutter/widgets.dart';

import '../config/device_type.dart';
import '../core/adaptive_data.dart';
import '../device/screen_size.dart';

/// A widget that conditionally shows or hides its child based on device type.
///
/// ```dart
/// AdaptiveVisibility(
///   visibleOn: [DeviceType.tablet, DeviceType.desktop],
///   child: SideNavigation(),
/// )
/// ```
class AdaptiveVisibility extends StatelessWidget {
  /// The widget to show/hide.
  final Widget child;

  /// Device types on which the child should be visible.
  /// If not specified, visibility is controlled by [hiddenOn].
  final List<DeviceType>? visibleOn;

  /// Device types on which the child should be hidden.
  /// Only used if [visibleOn] is not specified.
  final List<DeviceType>? hiddenOn;

  /// Widget to show when the child is hidden.
  /// Defaults to a zero-sized SizedBox.
  final Widget? replacement;

  /// Whether to maintain state when hidden.
  /// If true, uses Visibility widget; if false, removes the widget entirely.
  final bool maintainState;

  /// Creates an [AdaptiveVisibility] widget.
  const AdaptiveVisibility({
    super.key,
    required this.child,
    this.visibleOn,
    this.hiddenOn,
    this.replacement,
    this.maintainState = false,
  }) : assert(
         visibleOn != null || hiddenOn != null,
         'Either visibleOn or hiddenOn must be specified',
       );

  /// Creates a visibility widget that shows on phone only.
  const AdaptiveVisibility.phoneOnly({
    super.key,
    required this.child,
    this.replacement,
    this.maintainState = false,
  }) : visibleOn = const [DeviceType.phone],
       hiddenOn = null;

  /// Creates a visibility widget that shows on tablet only.
  const AdaptiveVisibility.tabletOnly({
    super.key,
    required this.child,
    this.replacement,
    this.maintainState = false,
  }) : visibleOn = const [DeviceType.tablet],
       hiddenOn = null;

  /// Creates a visibility widget that shows on desktop only.
  const AdaptiveVisibility.desktopOnly({
    super.key,
    required this.child,
    this.replacement,
    this.maintainState = false,
  }) : visibleOn = const [DeviceType.desktop],
       hiddenOn = null;

  /// Creates a visibility widget that shows on tablet and desktop.
  const AdaptiveVisibility.tabletUp({
    super.key,
    required this.child,
    this.replacement,
    this.maintainState = false,
  }) : visibleOn = const [DeviceType.tablet, DeviceType.desktop],
       hiddenOn = null;

  /// Creates a visibility widget that hides on phone.
  const AdaptiveVisibility.hideOnPhone({
    super.key,
    required this.child,
    this.replacement,
    this.maintainState = false,
  }) : visibleOn = null,
       hiddenOn = const [DeviceType.phone, DeviceType.foldable];

  @override
  Widget build(BuildContext context) {
    final data = AdaptiveData.of(context);
    final info = data.getDeviceInfo(context);
    final deviceType = info.deviceType;

    bool isVisible;
    if (visibleOn != null) {
      isVisible = visibleOn!.contains(deviceType);
    } else {
      isVisible = !hiddenOn!.contains(deviceType);
    }

    if (maintainState) {
      return Visibility(
        visible: isVisible,
        maintainState: true,
        maintainSize: false,
        maintainAnimation: true,
        child: child,
      );
    }

    if (isVisible) {
      return child;
    }

    return replacement ?? const SizedBox.shrink();
  }
}

/// A widget that conditionally shows or hides its child based on screen size.
///
/// ```dart
/// ResponsiveVisibility(
///   visibleWhen: (size) => size >= ScreenSize.md,
///   child: ExtendedInfo(),
/// )
/// ```
class ResponsiveVisibility extends StatelessWidget {
  /// The widget to show/hide.
  final Widget child;

  /// Predicate function to determine visibility.
  final bool Function(ScreenSize size)? visibleWhen;

  /// Screen sizes on which the child should be visible.
  final List<ScreenSize>? visibleOn;

  /// Screen sizes on which the child should be hidden.
  final List<ScreenSize>? hiddenOn;

  /// Widget to show when the child is hidden.
  final Widget? replacement;

  /// Whether to maintain state when hidden.
  final bool maintainState;

  /// Creates a [ResponsiveVisibility] widget.
  const ResponsiveVisibility({
    super.key,
    required this.child,
    this.visibleWhen,
    this.visibleOn,
    this.hiddenOn,
    this.replacement,
    this.maintainState = false,
  }) : assert(
         visibleWhen != null || visibleOn != null || hiddenOn != null,
         'Either visibleWhen, visibleOn, or hiddenOn must be specified',
       );

  /// Shows the child only on small screens (xs, sm).
  const ResponsiveVisibility.smallOnly({
    super.key,
    required this.child,
    this.replacement,
    this.maintainState = false,
  }) : visibleWhen = null,
       visibleOn = const [ScreenSize.xs, ScreenSize.sm],
       hiddenOn = null;

  /// Shows the child only on large screens (lg, xl).
  const ResponsiveVisibility.largeOnly({
    super.key,
    required this.child,
    this.replacement,
    this.maintainState = false,
  }) : visibleWhen = null,
       visibleOn = const [ScreenSize.lg, ScreenSize.xl],
       hiddenOn = null;

  @override
  Widget build(BuildContext context) {
    final data = AdaptiveData.of(context);
    final info = data.getDeviceInfo(context);
    final screenSize = info.screenSize;

    bool isVisible;
    if (visibleWhen != null) {
      isVisible = visibleWhen!(screenSize);
    } else if (visibleOn != null) {
      isVisible = visibleOn!.contains(screenSize);
    } else {
      isVisible = !hiddenOn!.contains(screenSize);
    }

    if (maintainState) {
      return Visibility(
        visible: isVisible,
        maintainState: true,
        maintainSize: false,
        maintainAnimation: true,
        child: child,
      );
    }

    if (isVisible) {
      return child;
    }

    return replacement ?? const SizedBox.shrink();
  }
}
