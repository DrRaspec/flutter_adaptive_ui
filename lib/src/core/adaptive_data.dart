import 'package:flutter/widgets.dart';

import '../config/breakpoints.dart';
import '../config/design_size.dart';
import '../device/device_info.dart';
import '../device/screen_size.dart';

/// InheritedWidget that provides adaptive configuration to descendant widgets.
///
/// This is used internally by [AdaptiveScope] to pass configuration down
/// the widget tree.
class AdaptiveData extends InheritedWidget {
  /// The breakpoints configuration.
  final AdaptiveBreakpoints breakpoints;

  /// The design size configuration.
  final DesignSize designSize;

  /// The screen size breakpoints configuration.
  final ScreenSizeBreakpoints screenSizeBreakpoints;

  /// Creates adaptive data with the given configuration.
  const AdaptiveData({
    super.key,
    required this.breakpoints,
    required this.designSize,
    required this.screenSizeBreakpoints,
    required super.child,
  });

  /// Gets the nearest [AdaptiveData] from the widget tree.
  ///
  /// Throws an error if [AdaptiveScope] is not found in the ancestor tree.
  static AdaptiveData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<AdaptiveData>();
    if (data == null) {
      throw FlutterError(
        'AdaptiveData.of() called with a context that does not contain an AdaptiveScope.\n'
        'No AdaptiveScope ancestor could be found starting from the context that was passed '
        'to AdaptiveData.of().\n'
        'Wrap your app with AdaptiveScope:\n'
        '  AdaptiveScope(\n'
        '    child: MaterialApp(...),\n'
        '  )',
      );
    }
    return data;
  }

  /// Gets the nearest [AdaptiveData] from the widget tree, or null if not found.
  static AdaptiveData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveData>();
  }

  /// Gets the device info for the current context.
  AdaptiveDeviceInfo getDeviceInfo(BuildContext context) {
    return AdaptiveDeviceInfo.of(
      context,
      breakpoints: breakpoints,
      designSizeConfig: designSize,
      screenSizeBreakpoints: screenSizeBreakpoints,
    );
  }

  @override
  bool updateShouldNotify(AdaptiveData oldWidget) {
    return breakpoints != oldWidget.breakpoints ||
        designSize != oldWidget.designSize ||
        screenSizeBreakpoints != oldWidget.screenSizeBreakpoints;
  }
}
