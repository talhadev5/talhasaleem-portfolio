import 'package:flutter/material.dart';

/// Corner-radius scale as a [ThemeExtension].
class AppRadii extends ThemeExtension<AppRadii> {
  const AppRadii({
    this.sm = 8,
    this.md = 12,
    this.lg = 20,
    this.xl = 28,
    this.pill = 999,
  });

  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double pill;

  static const AppRadii standard = AppRadii();

  @override
  AppRadii copyWith({double? sm, double? md, double? lg, double? xl, double? pill}) {
    return AppRadii(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      pill: pill ?? this.pill,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) return this;
    return AppRadii(
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
      xl: xl + (other.xl - xl) * t,
      pill: pill + (other.pill - pill) * t,
    );
  }
}
