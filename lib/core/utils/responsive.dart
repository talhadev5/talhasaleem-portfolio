import 'package:flutter/widgets.dart';

enum DeviceType { mobile, tablet, desktop }

/// Breakpoints and helpers used across the site for consistent
/// responsive behavior (mobile / tablet / desktop).
class Responsive {
  Responsive._();

  static const double mobileMax = 699;
  static const double tabletMax = 1099;
  static const double contentMaxWidth = 1200;

  static DeviceType deviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileMax) return DeviceType.mobile;
    if (width <= tabletMax) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) => deviceType(context) == DeviceType.mobile;
  static bool isTablet(BuildContext context) => deviceType(context) == DeviceType.tablet;
  static bool isDesktop(BuildContext context) => deviceType(context) == DeviceType.desktop;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop;
    }
  }

  static EdgeInsets pageHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final desktopPadding = width > contentMaxWidth ? (width - contentMaxWidth) / 2 : 64.0;
    return EdgeInsets.symmetric(
      horizontal: value(context, mobile: 20, tablet: 48, desktop: desktopPadding),
    );
  }
}
