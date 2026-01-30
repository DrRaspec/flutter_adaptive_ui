import 'package:flutter/widgets.dart';

import '../core/adaptive_data.dart';

/// Internal holder for the current AdaptiveData context.
///
/// This is used by the num extensions to access the device info.
/// It should be set by the AdaptiveScope or builder widgets.
class AdaptiveContext {
  static BuildContext? _context;

  /// Sets the current context for extensions to use.
  static void setContext(BuildContext context) {
    _context = context;
  }

  /// Gets the current context, throwing if not set.
  static BuildContext get context {
    if (_context == null) {
      throw FlutterError(
        'AdaptiveContext not initialized.\n'
        'Make sure to wrap your app with AdaptiveScope and use the extensions '
        'within a build method where context is available.\n'
        'Alternatively, use the setWidth/setHeight methods on AdaptiveDeviceInfo.',
      );
    }
    return _context!;
  }

  /// Gets the current context, or null if not set.
  static BuildContext? get maybeContext => _context;
}

/// Extension on [num] for adaptive sizing.
///
/// These extensions allow you to write responsive dimensions like:
/// ```dart
/// Container(
///   width: 200.aw,   // adaptive width
///   height: 100.ah,  // adaptive height
///   padding: EdgeInsets.all(16.ar), // adaptive radius
///   child: Text('Hello', style: TextStyle(fontSize: 16.asp)),
/// )
/// ```
extension AdaptiveNumExtension on num {
  /// Adaptive width - scales based on the design width.
  ///
  /// If your design is 375px wide and the actual screen is 750px,
  /// then `100.aw` will return `200.0`.
  double get aw {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    return info.setWidth(this);
  }

  /// Adaptive height - scales based on the design height.
  ///
  /// If your design is 812px tall and the actual screen is 1624px,
  /// then `100.ah` will return `200.0`.
  double get ah {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    return info.setHeight(this);
  }

  /// Adaptive radius - scales uniformly using the smaller ratio.
  ///
  /// This is ideal for border radius, icon sizes, and other values
  /// that should scale proportionally without distortion.
  double get ar {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    return info.setRadius(this);
  }

  /// Adaptive font size - scales for typography.
  ///
  /// Similar to `ar` but specifically for font sizes.
  double get asp {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    return info.setSp(this);
  }

  /// Percentage of screen width.
  ///
  /// `50.pw` returns 50% of the screen width.
  double get pw {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    return info.screenWidth * (this / 100);
  }

  /// Percentage of screen height.
  ///
  /// `50.ph` returns 50% of the screen height.
  double get ph {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    return info.screenHeight * (this / 100);
  }

  /// Creates a horizontal SizedBox with adaptive width.
  SizedBox get gapW => SizedBox(width: aw);

  /// Creates a vertical SizedBox with adaptive height.
  SizedBox get gapH => SizedBox(height: ah);

  /// Diagonal scaling - scales by width * height product.
  ///
  /// Useful for values that should scale with screen area.
  double get diagonal {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    return toDouble() * info.scaleWidth * info.scaleHeight;
  }

  /// Diameter scaling - scales by max(width, height) ratio.
  ///
  /// Useful for larger scaling effects.
  double get diameter {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return toDouble();
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return toDouble();
    final info = data.getDeviceInfo(context);
    final maxScale = info.scaleWidth > info.scaleHeight
        ? info.scaleWidth
        : info.scaleHeight;
    return toDouble() * maxScale;
  }
}
