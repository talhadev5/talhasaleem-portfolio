import 'package:flutter/material.dart';

/// Animation-duration + curve tokens as a [ThemeExtension]. A single
/// [reduced] flag (wired from `MediaQuery.disableAnimationsOf` via
/// `context.motion` in `app_theme_x.dart`) collapses every duration to
/// near-zero so the site stays fully usable with reduced-motion on,
/// without every animated widget needing its own branch.
class AppDurations extends ThemeExtension<AppDurations> {
  const AppDurations({
    this.fast = const Duration(milliseconds: 200),
    this.base = const Duration(milliseconds: 350),
    this.slow = const Duration(milliseconds: 600),
    this.themeSwitch = const Duration(milliseconds: 400),
  });

  final Duration fast;
  final Duration base;
  final Duration slow;

  /// Dedicated duration for the dark/light color-scheme crossfade.
  final Duration themeSwitch;

  static const AppDurations standard = AppDurations();

  static const Curve entrance = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve stateChange = Curves.easeInOut;

  @override
  AppDurations copyWith({Duration? fast, Duration? base, Duration? slow, Duration? themeSwitch}) {
    return AppDurations(
      fast: fast ?? this.fast,
      base: base ?? this.base,
      slow: slow ?? this.slow,
      themeSwitch: themeSwitch ?? this.themeSwitch,
    );
  }

  @override
  AppDurations lerp(ThemeExtension<AppDurations>? other, double t) {
    if (other is! AppDurations) return this;
    return t < 0.5 ? this : other;
  }
}
