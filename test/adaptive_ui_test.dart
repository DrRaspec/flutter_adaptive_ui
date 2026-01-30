import 'dart:ui' show Size;
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_ui/adaptive_ui.dart';

void main() {
  group('AdaptiveBreakpoints', () {
    test('default breakpoints detect phone for small screens', () {
      const breakpoints = AdaptiveBreakpoints();
      final deviceType = breakpoints.getDeviceType(375, 812);
      expect(deviceType, DeviceType.phone);
    });

    test('default breakpoints detect tablet for medium screens', () {
      const breakpoints = AdaptiveBreakpoints();
      final deviceType = breakpoints.getDeviceType(768, 1024);
      expect(deviceType, DeviceType.tablet);
    });

    test('default breakpoints detect desktop for large screens', () {
      const breakpoints = AdaptiveBreakpoints();
      final deviceType = breakpoints.getDeviceType(1440, 900);
      expect(deviceType, DeviceType.desktop);
    });

    test('custom breakpoints work correctly', () {
      const breakpoints = AdaptiveBreakpoints(phone: 500, tablet: 800);

      expect(breakpoints.getDeviceType(400, 800), DeviceType.phone);
      expect(breakpoints.getDeviceType(600, 800), DeviceType.tablet);
      expect(breakpoints.getDeviceType(900, 800), DeviceType.desktop);
    });
  });

  group('ScreenSizeBreakpoints', () {
    test('getScreenSize returns correct categories', () {
      const breakpoints = ScreenSizeBreakpoints();

      expect(breakpoints.getScreenSize(300), ScreenSize.xs);
      expect(breakpoints.getScreenSize(400), ScreenSize.sm);
      expect(breakpoints.getScreenSize(700), ScreenSize.md);
      expect(breakpoints.getScreenSize(1000), ScreenSize.lg);
      expect(breakpoints.getScreenSize(1400), ScreenSize.xl);
    });
  });

  group('DeviceType', () {
    test('isMobile returns true for phone and foldable', () {
      expect(DeviceType.phone.isMobile, true);
      expect(DeviceType.foldable.isMobile, true);
      expect(DeviceType.tablet.isMobile, false);
      expect(DeviceType.desktop.isMobile, false);
    });

    test('isLargeScreen returns true for tablet and desktop', () {
      expect(DeviceType.tablet.isLargeScreen, true);
      expect(DeviceType.desktop.isLargeScreen, true);
      expect(DeviceType.phone.isLargeScreen, false);
    });
  });

  group('ScreenSize', () {
    test('comparison operators work correctly', () {
      expect(ScreenSize.md >= ScreenSize.sm, true);
      expect(ScreenSize.xs < ScreenSize.lg, true);
      expect(ScreenSize.xl > ScreenSize.md, true);
    });

    test('isSmall, isMedium, isLarge work correctly', () {
      expect(ScreenSize.xs.isSmall, true);
      expect(ScreenSize.sm.isSmall, true);
      expect(ScreenSize.md.isMedium, true);
      expect(ScreenSize.lg.isLarge, true);
      expect(ScreenSize.xl.isLarge, true);
    });
  });

  group('DesignSize', () {
    test('default sizes are correct', () {
      const designSize = DesignSize();
      expect(designSize.phone, const Size(375, 812));
      expect(designSize.tablet, const Size(768, 1024));
      expect(designSize.desktop, const Size(1440, 900));
    });

    test('DesignSize.all creates uniform sizes', () {
      final designSize = DesignSize.all(const Size(400, 800));
      expect(designSize.phone, const Size(400, 800));
      expect(designSize.tablet, const Size(400, 800));
      expect(designSize.desktop, const Size(400, 800));
    });
  });
}
