import 'package:flutter/material.dart';
import 'package:flutter_adaptive_kit/adaptive_ui.dart';

void main() {
  runApp(const MyApp());
}

/// Example app demonstrating adaptive_ui package features.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap your app with AdaptiveScope to enable adaptive features
    return AdaptiveScope(
      // Optional: customize breakpoints
      breakpoints: const AdaptiveBreakpoints(
        phone: 600,
        tablet: 1024,
        desktop: 1440,
      ),
      // Optional: set your design size from Figma/XD
      designSize: const DesignSize(
        phone: Size(375, 812),
        tablet: Size(768, 1024),
        desktop: Size(1440, 900),
      ),
      child: MaterialApp(
        title: 'Adaptive UI Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

/// Home page demonstrating adaptive layouts
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Set context for extensions to work
    AdaptiveContext.setContext(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive UI Demo'),
        actions: [
          // Show device info in app bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${context.deviceType.name} | ${context.screenSize.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      // Different navigation based on device type
      drawer: context.isPhone ? const AppDrawer() : null,
      body: AdaptiveBuilder(
        // Phone layout: single column with bottom nav
        phone: (context, info) => const PhoneLayout(),
        // Tablet layout: master-detail
        tablet: (context, info) => const TabletLayout(),
        // Desktop layout: full dashboard
        desktop: (context, info) => const DesktopLayout(),
      ),
      // Show bottom nav only on phone
      bottomNavigationBar: AdaptiveVisibility.phoneOnly(
        child: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

/// Phone layout - single column
class PhoneLayout extends StatelessWidget {
  const PhoneLayout({super.key});

  @override
  Widget build(BuildContext context) {
    AdaptiveContext.setContext(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(AdaptiveSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DeviceInfoCard(),
          SizedBox(height: AdaptiveSpacing.md(context)),
          const OrientationDemo(),
          SizedBox(height: AdaptiveSpacing.md(context)),
          const ExtensionsDemo(),
          SizedBox(height: AdaptiveSpacing.md(context)),
          const ResponsiveGridDemo(),
        ],
      ),
    );
  }
}

/// Tablet layout - master-detail
class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    AdaptiveContext.setContext(context);

    return Row(
      children: [
        // Side navigation
        NavigationRail(
          selectedIndex: 0,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AdaptiveSpacing.lg(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DeviceInfoCard(),
                SizedBox(height: AdaptiveSpacing.lg(context)),
                const OrientationDemo(),
                SizedBox(height: AdaptiveSpacing.lg(context)),
                const ExtensionsDemo(),
                SizedBox(height: AdaptiveSpacing.lg(context)),
                const ResponsiveGridDemo(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Desktop layout - full dashboard with sidebar
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    AdaptiveContext.setContext(context);

    return Row(
      children: [
        // Extended navigation
        NavigationRail(
          extended: true,
          selectedIndex: 0,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.analytics),
              label: Text('Analytics'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        // Main content area
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AdaptiveSpacing.xl(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: DeviceInfoCard()),
                    SizedBox(width: AdaptiveSpacing.lg(context)),
                    const Expanded(child: ExtensionsDemo()),
                  ],
                ),
                SizedBox(height: AdaptiveSpacing.xl(context)),
                const ResponsiveGridDemo(),
              ],
            ),
          ),
        ),
        const VerticalDivider(thickness: 1, width: 1),
        // Right sidebar
        SizedBox(
          width: 300,
          child: Padding(
            padding: EdgeInsets.all(AdaptiveSpacing.md(context)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ListTile(leading: Icon(Icons.add), title: Text('New Item')),
                ListTile(leading: Icon(Icons.upload), title: Text('Import')),
                ListTile(leading: Icon(Icons.download), title: Text('Export')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Card showing current device info
class DeviceInfoCard extends StatelessWidget {
  const DeviceInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final info = context.deviceInfo;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AdaptiveSpacing.md(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Information',
              style: TextStyle(
                fontSize: AdaptiveFontSize.title(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            _InfoRow('Device Type', info.deviceType.name),
            _InfoRow('Screen Size', info.screenSize.name),
            _InfoRow(
              'Dimensions',
              '${info.screenWidth.toInt()} x ${info.screenHeight.toInt()}',
            ),
            _InfoRow('Orientation', info.orientation.name),
            _InfoRow('Pixel Ratio', info.pixelRatio.toStringAsFixed(2)),
            _InfoRow('Scale Width', info.scaleWidth.toStringAsFixed(3)),
            _InfoRow('Scale Height', info.scaleHeight.toStringAsFixed(3)),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('isPhone: ${context.isPhone}')),
                Chip(label: Text('isTablet: ${context.isTablet}')),
                Chip(label: Text('isDesktop: ${context.isDesktop}')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}

/// Demo showing extension methods
class ExtensionsDemo extends StatelessWidget {
  const ExtensionsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    AdaptiveContext.setContext(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AdaptiveSpacing.md(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Extension Methods Demo',
              style: TextStyle(
                fontSize: AdaptiveFontSize.title(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            // Box scaled with .aw (adaptive width)
            Container(
              width: 200.aw,
              height: 60.ah,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(12.ar),
              ),
              alignment: Alignment.center,
              child: Text(
                '200.aw x 60.ah\nBorderRadius: 12.ar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.asp),
              ),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            // Percentage-based sizing
            Container(
              width: 50.pw, // 50% of screen width
              height: 40,
              color: Colors.blue.shade100,
              alignment: Alignment.center,
              child: const Text('50.pw (50% width)'),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            // Responsive values
            Text(
              'Responsive Value Example:',
              style: TextStyle(fontSize: AdaptiveFontSize.body(context)),
            ),
            const SizedBox(height: 8),
            Text(
              'Padding: ${context.adaptive<double>(phone: 16, tablet: 24, desktop: 32).toInt()}px',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Demo showing responsive grid
class ResponsiveGridDemo extends StatelessWidget {
  const ResponsiveGridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Get columns based on screen size
    final columns = context.responsive<int>(xs: 1, sm: 2, md: 3, lg: 4, xl: 6);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AdaptiveSpacing.md(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Grid ($columns columns)',
              style: TextStyle(
                fontSize: AdaptiveFontSize.title(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: AdaptiveSpacing.sm(context),
                mainAxisSpacing: AdaptiveSpacing.sm(context),
                childAspectRatio: 1,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .primaries[index % Colors.primaries.length]
                        .shade100,
                    borderRadius: BorderRadius.circular(8.ar),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: AdaptiveFontSize.headline(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Demo showing orientation-specific layouts
class OrientationDemo extends StatelessWidget {
  const OrientationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AdaptiveSpacing.md(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orientation Demo',
              style: TextStyle(
                fontSize: AdaptiveFontSize.title(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            // Show current orientation
            Chip(
              avatar: Icon(
                context.isPortrait
                    ? Icons.stay_current_portrait
                    : Icons.stay_current_landscape,
              ),
              label: Text(
                context.isPortrait ? 'Portrait Mode' : 'Landscape Mode',
              ),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            // Orientation-specific layout
            OrientationLayout(
              portrait: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.phone_android, size: 32),
                    SizedBox(height: 8),
                    Text('Portrait Layout'),
                    Text('Stacked vertically'),
                  ],
                ),
              ),
              landscape: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_android, size: 32),
                    SizedBox(width: 16),
                    Column(
                      children: [
                        Text('Landscape Layout'),
                        Text('Side by side'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AdaptiveSpacing.sm(context)),
            // Orientation-specific values
            Text(
              'Orientation Values:',
              style: TextStyle(fontSize: AdaptiveFontSize.body(context)),
            ),
            const SizedBox(height: 8),
            Text(
              'Columns: ${context.orientationValue<int>(portrait: 2, landscape: 4)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Padding: ${context.adaptiveOrientation<double>(phonePortrait: 16, phoneLandscape: 8, tabletPortrait: 24, tabletLandscape: 16).toInt()}px',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple drawer for phone layout
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Text('Adaptive UI', style: TextStyle(fontSize: 24)),
          ),
          const ListTile(leading: Icon(Icons.home), title: Text('Home')),
          const ListTile(leading: Icon(Icons.search), title: Text('Search')),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
