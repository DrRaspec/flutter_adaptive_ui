import 'package:flutter/widgets.dart';

import '../config/breakpoints.dart';
import '../config/design_size.dart';
import '../config/device_type.dart';
import 'screen_size.dart';

/// Contains all adaptive device and screen information.
///
/// This class provides easy access to screen metrics, device type,
/// and scaling ratios for responsive design.
class AdaptiveDeviceInfo {
  /// The current screen width in logical pixels.
  final double screenWidth;

  /// The current screen height in logical pixels.
  final double screenHeight;

  /// The current device orientation.
  final Orientation orientation;

  /// The device pixel ratio (for hi-dpi screens).
  final double pixelRatio;

  /// The detected device type.
  final DeviceType deviceType;

  /// The detected screen size category.
  final ScreenSize screenSize;

  /// The design size used for scaling calculations.
  final Size designSize;

  /// The status bar height (top safe area).
  final double statusBarHeight;

  /// The bottom bar height (bottom safe area).
  final double bottomBarHeight;

  /// The text scale factor from system settings.
  final double textScaleFactor;

  /// The safe area padding.
  final EdgeInsets safeAreaPadding;

  /// Creates device info from screen metrics.
  const AdaptiveDeviceInfo({
    required this.screenWidth,
    required this.screenHeight,
    required this.orientation,
    required this.pixelRatio,
    required this.deviceType,
    required this.screenSize,
    required this.designSize,
    required this.statusBarHeight,
    required this.bottomBarHeight,
    required this.textScaleFactor,
    required this.safeAreaPadding,
  });

  /// Creates device info from a BuildContext.
  factory AdaptiveDeviceInfo.of(
    BuildContext context, {
    required AdaptiveBreakpoints breakpoints,
    required DesignSize designSizeConfig,
    required ScreenSizeBreakpoints screenSizeBreakpoints,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final width = size.width;
    final height = size.height;
    final orientation = mediaQuery.orientation;
    final deviceType = breakpoints.getDeviceType(width, height);
    final screenSize = screenSizeBreakpoints.getScreenSize(width);

    // Select appropriate design size based on device type
    Size designSize;
    switch (deviceType) {
      case DeviceType.phone:
      case DeviceType.foldable:
        designSize = designSizeConfig.phone;
        break;
      case DeviceType.tablet:
        designSize = designSizeConfig.tablet;
        break;
      case DeviceType.desktop:
        designSize = designSizeConfig.desktop;
        break;
    }

    return AdaptiveDeviceInfo(
      screenWidth: width,
      screenHeight: height,
      orientation: orientation,
      pixelRatio: mediaQuery.devicePixelRatio,
      deviceType: deviceType,
      screenSize: screenSize,
      designSize: designSize,
      statusBarHeight: mediaQuery.padding.top,
      bottomBarHeight: mediaQuery.padding.bottom,
      textScaleFactor: mediaQuery.textScaler.scale(1.0),
      safeAreaPadding: mediaQuery.padding,
    );
  }

  /// The width scale ratio (actual width / design width).
  double get scaleWidth => screenWidth / designSize.width;

  /// The height scale ratio (actual height / design height).
  double get scaleHeight => screenHeight / designSize.height;

  /// The minimum of width and height scale (for radius/uniform scaling).
  double get scaleRadius => scaleWidth < scaleHeight ? scaleWidth : scaleHeight;

  /// Returns true if the device is in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns true if the device is in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns true if this is a phone.
  bool get isPhone => deviceType == DeviceType.phone;

  /// Returns true if this is a tablet.
  bool get isTablet => deviceType == DeviceType.tablet;

  /// Returns true if this is a desktop.
  bool get isDesktop => deviceType == DeviceType.desktop;

  /// Returns true if this is a foldable device.
  bool get isFoldable => deviceType == DeviceType.foldable;

  /// Scales a width value based on the design size.
  double setWidth(num width) => width * scaleWidth;

  /// Scales a height value based on the design size.
  double setHeight(num height) => height * scaleHeight;

  /// Scales a value uniformly (uses the smaller of width/height ratio).
  double setRadius(num radius) => radius * scaleRadius;

  /// Scales a font size with text scale factor consideration.
  double setSp(num fontSize) => fontSize * scaleRadius;

  @override
  String toString() {
    return 'AdaptiveDeviceInfo(${screenWidth.toStringAsFixed(0)}x${screenHeight.toStringAsFixed(0)}, '
        '$deviceType, $screenSize, $orientation)';
  }
}
