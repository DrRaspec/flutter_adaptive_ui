import 'package:flutter/widgets.dart';

import '../core/adaptive_data.dart';
import '../config/device_type.dart';

/// Pre-defined adaptive spacing values.
///
/// Provides consistent spacing that scales across device types.
///
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(AdaptiveSpacing.md(context)),
///   child: MyWidget(),
/// )
/// ```
class AdaptiveSpacing {
  AdaptiveSpacing._();

  // ===== Base spacing values (phone/tablet/desktop) =====

  static const double _xxsPhone = 2;
  static const double _xxsTablet = 3;
  static const double _xxsDesktop = 4;

  static const double _xsPhone = 4;
  static const double _xsTablet = 6;
  static const double _xsDesktop = 8;

  static const double _smPhone = 8;
  static const double _smTablet = 12;
  static const double _smDesktop = 16;

  static const double _mdPhone = 16;
  static const double _mdTablet = 20;
  static const double _mdDesktop = 24;

  static const double _lgPhone = 24;
  static const double _lgTablet = 32;
  static const double _lgDesktop = 40;

  static const double _xlPhone = 32;
  static const double _xlTablet = 48;
  static const double _xlDesktop = 64;

  static const double _xxlPhone = 48;
  static const double _xxlTablet = 64;
  static const double _xxlDesktop = 96;

  // ===== Spacing getters =====

  /// Extra extra small spacing (2/3/4 for phone/tablet/desktop)
  static double xxs(BuildContext context) => _getValue(
    context,
    phone: _xxsPhone,
    tablet: _xxsTablet,
    desktop: _xxsDesktop,
  );

  /// Extra small spacing (4/6/8 for phone/tablet/desktop)
  static double xs(BuildContext context) => _getValue(
    context,
    phone: _xsPhone,
    tablet: _xsTablet,
    desktop: _xsDesktop,
  );

  /// Small spacing (8/12/16 for phone/tablet/desktop)
  static double sm(BuildContext context) => _getValue(
    context,
    phone: _smPhone,
    tablet: _smTablet,
    desktop: _smDesktop,
  );

  /// Medium spacing (16/20/24 for phone/tablet/desktop)
  static double md(BuildContext context) => _getValue(
    context,
    phone: _mdPhone,
    tablet: _mdTablet,
    desktop: _mdDesktop,
  );

  /// Large spacing (24/32/40 for phone/tablet/desktop)
  static double lg(BuildContext context) => _getValue(
    context,
    phone: _lgPhone,
    tablet: _lgTablet,
    desktop: _lgDesktop,
  );

  /// Extra large spacing (32/48/64 for phone/tablet/desktop)
  static double xl(BuildContext context) => _getValue(
    context,
    phone: _xlPhone,
    tablet: _xlTablet,
    desktop: _xlDesktop,
  );

  /// Extra extra large spacing (48/64/96 for phone/tablet/desktop)
  static double xxl(BuildContext context) => _getValue(
    context,
    phone: _xxlPhone,
    tablet: _xxlTablet,
    desktop: _xxlDesktop,
  );

  // ===== SizedBox shortcuts =====

  /// Horizontal gap - extra small
  static SizedBox gapXs(BuildContext context) => SizedBox(width: xs(context));

  /// Horizontal gap - small
  static SizedBox gapSm(BuildContext context) => SizedBox(width: sm(context));

  /// Horizontal gap - medium
  static SizedBox gapMd(BuildContext context) => SizedBox(width: md(context));

  /// Horizontal gap - large
  static SizedBox gapLg(BuildContext context) => SizedBox(width: lg(context));

  /// Vertical gap - extra small
  static SizedBox gapVXs(BuildContext context) => SizedBox(height: xs(context));

  /// Vertical gap - small
  static SizedBox gapVSm(BuildContext context) => SizedBox(height: sm(context));

  /// Vertical gap - medium
  static SizedBox gapVMd(BuildContext context) => SizedBox(height: md(context));

  /// Vertical gap - large
  static SizedBox gapVLg(BuildContext context) => SizedBox(height: lg(context));

  // ===== Helper =====

  static double _getValue(
    BuildContext context, {
    required double phone,
    required double tablet,
    required double desktop,
  }) {
    final data = AdaptiveData.maybeOf(context);
    if (data == null) return phone;

    final info = data.getDeviceInfo(context);
    switch (info.deviceType) {
      case DeviceType.phone:
      case DeviceType.foldable:
        return phone;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }
}

/// Pre-defined adaptive font sizes.
///
/// ```dart
/// Text(
///   'Hello',
///   style: TextStyle(fontSize: AdaptiveFontSize.body(context)),
/// )
/// ```
class AdaptiveFontSize {
  AdaptiveFontSize._();

  /// Caption text size (10/11/12 for phone/tablet/desktop)
  static double caption(BuildContext context) =>
      AdaptiveSpacing._getValue(context, phone: 10, tablet: 11, desktop: 12);

  /// Small text size (12/13/14 for phone/tablet/desktop)
  static double small(BuildContext context) =>
      AdaptiveSpacing._getValue(context, phone: 12, tablet: 13, desktop: 14);

  /// Body text size (14/15/16 for phone/tablet/desktop)
  static double body(BuildContext context) =>
      AdaptiveSpacing._getValue(context, phone: 14, tablet: 15, desktop: 16);

  /// Subtitle text size (16/18/20 for phone/tablet/desktop)
  static double subtitle(BuildContext context) =>
      AdaptiveSpacing._getValue(context, phone: 16, tablet: 18, desktop: 20);

  /// Title text size (20/24/28 for phone/tablet/desktop)
  static double title(BuildContext context) =>
      AdaptiveSpacing._getValue(context, phone: 20, tablet: 24, desktop: 28);

  /// Headline text size (24/32/40 for phone/tablet/desktop)
  static double headline(BuildContext context) =>
      AdaptiveSpacing._getValue(context, phone: 24, tablet: 32, desktop: 40);

  /// Display text size (32/48/64 for phone/tablet/desktop)
  static double display(BuildContext context) =>
      AdaptiveSpacing._getValue(context, phone: 32, tablet: 48, desktop: 64);
}
