# Flutter Adaptive Kit

A comprehensive Flutter package for building responsive and adaptive user interfaces. Combines the best features from popular packages like flutter_screenutil, responsive_builder, responsive_framework, and sizer into one unified API.

[![pub package](https://img.shields.io/pub/v/flutter_adaptive_kit.svg)](https://pub.dev/packages/flutter_adaptive_kit)
[![License: BSD-3-Clause](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](LICENSE)

## Features

- 🎯 **Device Type Detection** - Detect phone, tablet, desktop, and foldable devices
- 📐 **Design Size Scaling** - Scale your UI based on your Figma/XD design size
- 🔧 **Extension Methods** - Simple `.aw`, `.ah`, `.asp`, `.ar`, `.diagonal`, `.diameter` extensions
- 🏗️ **Builder Widgets** - AdaptiveBuilder and ResponsiveBuilder for different layouts
- 📊 **Screen Size Categories** - Fine-grained xs/sm/md/lg/xl breakpoints
- 👁️ **Visibility Widgets** - Conditionally show/hide widgets based on screen
- 📏 **Pre-built Spacing** - Consistent spacing that scales across devices
- 🌐 **Platform Detection** - Detect iOS, Android, web, macOS, Windows, Linux
- 📱 **Landscape Support** - Separate breakpoints for portrait and landscape
- ⏳ **ensureScreenSize()** - Wait for screen size on web/desktop before init
- ✍️ **AdaptiveText** - Auto-scaling text widget

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_adaptive_kit: ^0.1.0
```


## Quick Start

### 1. Wrap your app with AdaptiveScope

```dart
import 'package:adaptive_ui/adaptive_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Optional: wait for screen size on web/desktop
  await AdaptiveUtils.ensureScreenSize();
  
  runApp(
    AdaptiveScope(
      // Set your Figma/XD design size
      designSize: const DesignSize(
        phone: Size(375, 812),    // iPhone 13 Mini
        tablet: Size(768, 1024),  // iPad
        desktop: Size(1440, 900),
      ),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
```

### 2. Use Extension Methods

```dart
// Set context for extensions (required once per build method)
AdaptiveContext.setContext(context);

Container(
  width: 200.aw,     // Adaptive width (scales with screen)
  height: 100.ah,    // Adaptive height
  padding: EdgeInsets.all(16.ar),  // Adaptive radius
  child: Text(
    'Hello!',
    style: TextStyle(fontSize: 16.asp),  // Adaptive font size
  ),
)

// Percentage-based sizing
Container(
  width: 50.pw,   // 50% of screen width
  height: 25.ph,  // 25% of screen height
)

// Advanced scaling
Container(
  width: 100.diagonal,  // Scales by width * height
  height: 50.diameter,  // Scales by max(width, height)
)
```

### 3. Use AdaptiveBuilder for Different Layouts

```dart
AdaptiveBuilder(
  phone: (context, info) => PhoneLayout(),
  tablet: (context, info) => TabletLayout(),
  desktop: (context, info) => DesktopLayout(),
)
```

### 4. Use Context Extensions

```dart
// Device type checks
if (context.isPhone) { ... }
if (context.isTablet) { ... }
if (context.isDesktop) { ... }

// Get responsive values
final padding = context.adaptive<double>(
  phone: 16,
  tablet: 24,
  desktop: 32,
);

// Screen size checks
final columns = context.responsive<int>(
  xs: 1, sm: 2, md: 3, lg: 4, xl: 6,
);

// Conditional helpers
if (context.largerThan(DeviceType.phone)) { ... }
if (context.smallerThan(DeviceType.desktop)) { ... }
```

### 5. Use AdaptiveText for Auto-scaling

```dart
AdaptiveText(
  'Hello World',
  style: TextStyle(fontSize: 16), // Auto-scaled!
)
```

### 6. Platform Detection

```dart
if (PlatformUtils.isWeb) { ... }
if (PlatformUtils.isMobile) { ... }
if (PlatformUtils.isDesktop) { ... }
if (PlatformUtils.isIOS) { ... }
```

### 7. Landscape Breakpoints

```dart
AdaptiveScope(
  breakpoints: AdaptiveBreakpoints.withLandscape(
    phone: 600, tablet: 1024, desktop: 1440,
    landscapePhone: 800, landscapeTablet: 1200, landscapeDesktop: 1600,
  ),
  child: MyApp(),
)
```

## API Reference

### Configuration Classes

| Class | Description |
|-------|-------------|
| `AdaptiveScope` | Main wrapper widget that provides configuration |
| `AdaptiveBreakpoints` | Customize device type breakpoints (with landscape support) |
| `DesignSize` | Set your design tool dimensions |

### Extension Methods on `num`

| Extension | Description |
|-----------|-------------|
| `.aw` | Adaptive width (scales based on design width) |
| `.ah` | Adaptive height (scales based on design height) |
| `.ar` | Adaptive radius (uniform scaling, min of w/h) |
| `.asp` | Adaptive font size |
| `.pw` | Percentage of screen width |
| `.ph` | Percentage of screen height |
| `.gapW` | Creates horizontal SizedBox |
| `.gapH` | Creates vertical SizedBox |
| `.diagonal` | Scales by w*h product |
| `.diameter` | Scales by max(w, h) |

### Builder Widgets

| Widget | Description |
|--------|-------------|
| `AdaptiveBuilder` | Different layouts per device type |
| `AdaptiveLayout` | Simpler version with direct widgets |
| `ResponsiveBuilder` | Different layouts per screen size (xs-xl) |
| `ResponsiveLayout` | Simpler version with direct widgets |

### Text Widgets

| Widget | Description |
|--------|-------------|
| `AdaptiveText` | Auto-scaling text widget |
| `AdaptiveRichText` | Auto-scaling rich text widget |

### Visibility Widgets

| Widget | Description |
|--------|-------------|
| `AdaptiveVisibility` | Show/hide based on device type |
| `ResponsiveVisibility` | Show/hide based on screen size |

### Utilities

| Class | Method/Property | Description |
|-------|-----------------|-------------|
| `AdaptiveUtils` | `ensureScreenSize()` | Wait for screen size (web/desktop) |
| `PlatformUtils` | `isWeb`, `isMobile`, `isDesktop` | Platform detection |
| `AdaptiveSpacing` | `xxs` to `xxl` | Pre-built spacing values |
| `AdaptiveFontSize` | `caption` to `display` | Pre-built font sizes |

## Example

See the [example](example/) folder for a complete demo app.

```bash
cd example
flutter run
```

## License

BSD-3-Clause License - see [LICENSE](LICENSE) for details.
