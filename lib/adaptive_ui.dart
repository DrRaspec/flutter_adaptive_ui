/// Adaptive UI - A comprehensive Flutter package for building responsive and adaptive UIs.
///
/// This package provides:
/// - Device type detection (phone, tablet, desktop, foldable)
/// - Breakpoint-based responsive layouts
/// - Design size initialization for pixel-perfect scaling
/// - Extension methods for responsive sizing (.aw, .ah, .asp, .ar)
/// - Builder widgets for adaptive layouts
/// - Platform detection utilities
/// - Landscape breakpoint support
library;

// Config
export 'src/config/breakpoints.dart';
export 'src/config/design_size.dart';
export 'src/config/device_type.dart';

// Core
export 'src/core/adaptive_data.dart';
export 'src/core/adaptive_scope.dart';

// Device
export 'src/device/device_info.dart';
export 'src/device/screen_size.dart';

// Extensions
export 'src/extensions/context_ext.dart';
export 'src/extensions/num_ext.dart';
export 'src/extensions/edge_insets_ext.dart';

// Responsive
export 'src/responsive/responsive_value.dart';
export 'src/responsive/spacing.dart';

// Utils
export 'src/utils/adaptive_utils.dart';
export 'src/utils/platform_utils.dart';

// Widgets
export 'src/widgets/adaptive_builder.dart';
export 'src/widgets/responsive_builder.dart';
export 'src/widgets/visibility.dart';
export 'src/widgets/adaptive_text.dart';
