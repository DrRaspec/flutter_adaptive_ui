# Flutter Adaptive Kit - Changelog

All notable changes to this project will be documented in this file.

## [0.1.2] - 2026-01-30

### Added
- `OrientationLayoutBuilder` widget for orientation-specific layouts
- `OrientationLayout` simpler widget version
- `AdaptiveOrientationBuilder` for device type + orientation combinations
- `context.orientationValue()` method for orientation-based values
- `context.adaptiveOrientation()` method for device + orientation values

## [0.1.1] - 2026-01-30

### Changed
- Removed package comparison table from README

## [0.1.0] - 2026-01-30

### Added

- **Core Package**
  - `AdaptiveScope` widget for wrapping your app with configuration
  - `AdaptiveBreakpoints` for customizable device type breakpoints
  - `DesignSize` configuration for Figma/XD design dimensions

- **Device Detection**
  - `DeviceType` enum (phone, tablet, desktop, foldable)
  - `ScreenSize` enum (xs, sm, md, lg, xl)
  - `AdaptiveDeviceInfo` class with full screen metrics
  - Foldable device detection via aspect ratio

- **Extension Methods**
  - `num` extensions: `.aw`, `.ah`, `.ar`, `.asp`, `.pw`, `.ph`, `.gapW`, `.gapH`
  - NEW: `.diagonal` and `.diameter` for advanced scaling
  - `EdgeInsets` extensions: `.aw`, `.ah`, `.ar`, `.awh`
  - `BorderRadius`, `Radius`, `BoxConstraints`, `Size` extensions
  - `BuildContext` extensions for device info and responsive values

- **Builder Widgets**
  - `AdaptiveBuilder` - Different widgets per device type
  - `AdaptiveLayout` - Simpler widget-based version
  - `ResponsiveBuilder` - Different widgets per screen size
  - `ResponsiveLayout` - Simpler widget-based version
  - `ResponsiveBreakpointBuilder` - Rebuilds on breakpoint changes

- **Text Widgets**
  - NEW: `AdaptiveText` - Auto-scaling text widget
  - NEW: `AdaptiveRichText` - Auto-scaling rich text widget

- **Visibility Widgets**
  - `AdaptiveVisibility` - Show/hide by device type
  - `ResponsiveVisibility` - Show/hide by screen size
  - Convenience constructors: `.phoneOnly`, `.tabletOnly`, `.tabletUp`, etc.

- **Utilities**
  - NEW: `AdaptiveUtils.ensureScreenSize()` for web/desktop initialization
  - NEW: `PlatformUtils` for detecting iOS, Android, web, macOS, Windows, Linux
  - `AdaptiveSpacing` - Pre-defined spacing (xxs to xxl)
  - `AdaptiveFontSize` - Pre-defined font sizes (caption to display)
  - `ResponsiveValue` - Type-safe responsive values by device type
  - `ScreenResponsiveValue` - Type-safe responsive values by screen size

- **Advanced Features**
  - NEW: Landscape breakpoint support (`AdaptiveBreakpoints.withLandscape`)
  - NEW: `useShortestSide` option for consistent orientation handling
  - Platform-aware device detection

- **Example App**
  - Complete demo showing phone/tablet/desktop layouts
  - Device info display
  - Extension methods demonstration
  - Responsive grid with dynamic columns
