import 'package:flutter/widgets.dart';

import '../core/adaptive_data.dart';
import 'num_ext.dart';

/// Extension on [EdgeInsets] for adaptive scaling.
///
/// These extensions allow you to scale EdgeInsets values:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(16).aw,  // scale all by width ratio
/// )
/// ```
extension AdaptiveEdgeInsetsExtension on EdgeInsets {
  /// Scales all values by the width ratio.
  EdgeInsets get aw {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return EdgeInsets.only(
      left: info.setWidth(left),
      top: info.setWidth(top),
      right: info.setWidth(right),
      bottom: info.setWidth(bottom),
    );
  }

  /// Scales all values by the height ratio.
  EdgeInsets get ah {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return EdgeInsets.only(
      left: info.setHeight(left),
      top: info.setHeight(top),
      right: info.setHeight(right),
      bottom: info.setHeight(bottom),
    );
  }

  /// Scales all values by the radius (uniform) ratio.
  EdgeInsets get ar {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return EdgeInsets.only(
      left: info.setRadius(left),
      top: info.setRadius(top),
      right: info.setRadius(right),
      bottom: info.setRadius(bottom),
    );
  }

  /// Scales horizontal values by width ratio, vertical by height ratio.
  EdgeInsets get awh {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return EdgeInsets.only(
      left: info.setWidth(left),
      top: info.setHeight(top),
      right: info.setWidth(right),
      bottom: info.setHeight(bottom),
    );
  }
}

/// Extension on [BorderRadius] for adaptive scaling.
extension AdaptiveBorderRadiusExtension on BorderRadius {
  /// Scales all radii by the uniform ratio.
  BorderRadius get ar {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return BorderRadius.only(
      topLeft: Radius.circular(info.setRadius(topLeft.x)),
      topRight: Radius.circular(info.setRadius(topRight.x)),
      bottomLeft: Radius.circular(info.setRadius(bottomLeft.x)),
      bottomRight: Radius.circular(info.setRadius(bottomRight.x)),
    );
  }
}

/// Extension on [Radius] for adaptive scaling.
extension AdaptiveRadiusExtension on Radius {
  /// Scales the radius by the uniform ratio.
  Radius get ar {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return Radius.circular(info.setRadius(x));
  }
}

/// Extension on [BoxConstraints] for adaptive scaling.
extension AdaptiveBoxConstraintsExtension on BoxConstraints {
  /// Scales all constraints by the width ratio.
  BoxConstraints get aw {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return BoxConstraints(
      minWidth: info.setWidth(minWidth),
      maxWidth: info.setWidth(maxWidth),
      minHeight: info.setWidth(minHeight),
      maxHeight: info.setWidth(maxHeight),
    );
  }

  /// Scales all constraints by the uniform ratio.
  BoxConstraints get ar {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return BoxConstraints(
      minWidth: info.setRadius(minWidth),
      maxWidth: info.setRadius(maxWidth),
      minHeight: info.setRadius(minHeight),
      maxHeight: info.setRadius(maxHeight),
    );
  }
}

/// Extension on [Size] for adaptive scaling.
extension AdaptiveSizeExtension on Size {
  /// Scales the size by width and height ratios respectively.
  Size get awh {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return Size(info.setWidth(width), info.setHeight(height));
  }

  /// Scales the size uniformly.
  Size get ar {
    final context = AdaptiveContext.maybeContext;
    if (context == null) return this;
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return this;
    final info = data.getDeviceInfo(context);
    return Size(info.setRadius(width), info.setRadius(height));
  }
}
