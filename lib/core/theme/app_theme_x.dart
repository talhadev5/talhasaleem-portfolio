import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_durations.dart';
import 'app_radii.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';

/// Ergonomic token access: `context.colors.primary`, `context.spacing.lg`,
/// etc. Every token lookup goes through `Theme.of(context)`, so it's
/// reactive to theme changes — the whole point of moving off static consts.
extension AppThemeX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;
  AppRadii get radii => Theme.of(this).extension<AppRadii>()!;
  AppShadows get shadows => Theme.of(this).extension<AppShadows>()!;
  AppDurations get durations => Theme.of(this).extension<AppDurations>()!;

  /// True when the platform/user has requested reduced motion. Animated
  /// widgets should check this and collapse to a near-zero duration
  /// instead of skipping the animation outright (so layout still settles
  /// the same way, just instantly).
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);

  /// A duration that's near-instant when [reduceMotion] is on, otherwise
  /// [base] unchanged. Use this instead of passing a raw token duration
  /// to any entrance/hover/transition animation.
  Duration motion(Duration base) => reduceMotion ? const Duration(milliseconds: 1) : base;
}
