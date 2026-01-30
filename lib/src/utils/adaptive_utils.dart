import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

/// Utilities for ensuring screen size is available before initialization.
///
/// This is especially important for web and desktop platforms where
/// the window size may not be immediately available.
class AdaptiveUtils {
  AdaptiveUtils._();

  /// Ensures screen size is available before proceeding.
  ///
  /// Call this before accessing screen dimensions in splash screens
  /// or during app initialization.
  ///
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await AdaptiveUtils.ensureScreenSize();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  /// Or use with FutureBuilder:
  /// ```dart
  /// FutureBuilder(
  ///   future: AdaptiveUtils.ensureScreenSize(),
  ///   builder: (context, snapshot) {
  ///     if (snapshot.connectionState == ConnectionState.done) {
  ///       return MyApp();
  ///     }
  ///     return SplashScreen();
  ///   },
  /// )
  /// ```
  static Future<void> ensureScreenSize([
    ui.FlutterView? window,
    Duration pollInterval = const Duration(milliseconds: 10),
  ]) async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();

    await Future.doWhile(() {
      window ??= binding.platformDispatcher.implicitView;

      if (window == null || window!.physicalSize.isEmpty) {
        return Future.delayed(pollInterval, () => true);
      }

      return false;
    });

    binding.allowFirstFrame();
  }

  /// Gets the current window size synchronously.
  ///
  /// Returns Size.zero if window is not available.
  static Size getWindowSize() {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    final window = binding.platformDispatcher.implicitView;
    if (window == null) return Size.zero;
    return window.physicalSize / window.devicePixelRatio;
  }

  /// Checks if the screen size is available.
  static bool get isScreenSizeAvailable {
    final size = getWindowSize();
    return size.width > 0 && size.height > 0;
  }
}
