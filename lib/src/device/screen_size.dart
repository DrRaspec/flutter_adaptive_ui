/// Screen size categories for responsive layouts.
///
/// These provide finer granularity than device types for responsive design.
enum ScreenSize {
  /// Extra small screens (< 360px width)
  xs,

  /// Small screens (360-600px width)
  sm,

  /// Medium screens (600-900px width)
  md,

  /// Large screens (900-1200px width)
  lg,

  /// Extra large screens (> 1200px width)
  xl,
}

/// Breakpoints for screen size categories.
class ScreenSizeBreakpoints {
  /// Threshold for small screens (default: 360)
  final double xs;

  /// Threshold for medium screens (default: 600)
  final double sm;

  /// Threshold for large screens (default: 900)
  final double md;

  /// Threshold for extra large screens (default: 1200)
  final double lg;

  /// Creates screen size breakpoints with custom values.
  const ScreenSizeBreakpoints({
    this.xs = 360,
    this.sm = 600,
    this.md = 900,
    this.lg = 1200,
  });

  /// Default screen size breakpoints.
  static const ScreenSizeBreakpoints defaults = ScreenSizeBreakpoints();

  /// Determines the screen size category based on width.
  ScreenSize getScreenSize(double width) {
    if (width < xs) {
      return ScreenSize.xs;
    } else if (width < sm) {
      return ScreenSize.sm;
    } else if (width < md) {
      return ScreenSize.md;
    } else if (width < lg) {
      return ScreenSize.lg;
    } else {
      return ScreenSize.xl;
    }
  }
}

/// Extension methods for ScreenSize
extension ScreenSizeExtension on ScreenSize {
  /// Returns true if this size is small (xs or sm)
  bool get isSmall => this == ScreenSize.xs || this == ScreenSize.sm;

  /// Returns true if this size is medium
  bool get isMedium => this == ScreenSize.md;

  /// Returns true if this size is large (lg or xl)
  bool get isLarge => this == ScreenSize.lg || this == ScreenSize.xl;

  /// Returns the index (0-4) for this screen size
  int get index {
    switch (this) {
      case ScreenSize.xs:
        return 0;
      case ScreenSize.sm:
        return 1;
      case ScreenSize.md:
        return 2;
      case ScreenSize.lg:
        return 3;
      case ScreenSize.xl:
        return 4;
    }
  }

  /// Comparison operators
  bool operator >=(ScreenSize other) => index >= other.index;
  bool operator <=(ScreenSize other) => index <= other.index;
  bool operator >(ScreenSize other) => index > other.index;
  bool operator <(ScreenSize other) => index < other.index;
}
