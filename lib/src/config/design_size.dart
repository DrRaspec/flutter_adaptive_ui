import 'package:flutter/widgets.dart';

/// Design size configuration for adaptive scaling.
///
/// The design size represents the base dimensions used in your design tool
/// (Figma, XD, Sketch, etc.). All scaling calculations will be based on
/// comparing the actual screen size to this design size.
class DesignSize {
  /// Default design size (iPhone 13 Mini - 375x812)
  static const Size defaultPhone = Size(375, 812);

  /// Default tablet design size (iPad - 768x1024)
  static const Size defaultTablet = Size(768, 1024);

  /// Default desktop design size (1440x900)
  static const Size defaultDesktop = Size(1440, 900);

  /// The base design size for phone layouts
  final Size phone;

  /// The base design size for tablet layouts
  final Size tablet;

  /// The base design size for desktop layouts
  final Size desktop;

  /// Creates a design size configuration.
  ///
  /// If only [phone] is provided, tablet and desktop will use their defaults.
  const DesignSize({
    this.phone = defaultPhone,
    this.tablet = defaultTablet,
    this.desktop = defaultDesktop,
  });

  /// Creates a design size with a single size for all device types.
  const DesignSize.all(Size size) : phone = size, tablet = size, desktop = size;

  /// Creates a design size from width and height values.
  DesignSize.fromDimensions({
    double phoneWidth = 375,
    double phoneHeight = 812,
    double tabletWidth = 768,
    double tabletHeight = 1024,
    double desktopWidth = 1440,
    double desktopHeight = 900,
  }) : phone = Size(phoneWidth, phoneHeight),
       tablet = Size(tabletWidth, tabletHeight),
       desktop = Size(desktopWidth, desktopHeight);
}
