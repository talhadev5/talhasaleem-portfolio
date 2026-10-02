import 'package:flutter/material.dart';

/// Brand color tokens as a [ThemeExtension] so dark/light can swap at
/// runtime via `Theme.of(context)` — a `static const` palette (the old
/// approach) can't be theme-reactive since consts are fixed at compile time.
///
/// Access via `context.colors` (see `app_theme_x.dart`), never by
/// constructing this class directly outside of [dark]/[light].
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.primary,
    required this.primaryText,
    required this.secondary,
    required this.onAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.glassFill,
    required this.glassBorder,
    required this.glassBorderHover,
    required this.divider,
    required this.success,
  });

  /// Page background.
  final Color background;

  /// First surface elevation (section bands, cards' base).
  final Color surface;

  /// Second surface elevation (cards sitting on top of [surface]).
  final Color surfaceElevated;

  /// Brand blue (Flutter-inspired) — used for fills, icons, borders and
  /// glows. Not guaranteed to pass text contrast against
  /// [background]/[surface] in light mode; use [primaryText] for
  /// blue-colored text/labels.
  final Color primary;

  /// Contrast-corrected blue for text/label use on the current theme's
  /// background (deepened in light mode so it clears WCAG AA).
  final Color primaryText;

  /// A lighter shade from the same blue family as [primary] (closer to
  /// Flutter's sky-blue logo accent) — used for secondary emphasis,
  /// gradients and glows alongside the primary brand blue.
  final Color secondary;

  /// Near-black ink used for text/icons painted on top of [primary] or
  /// [secondary] fills — bright accent fills fail AA against white text,
  /// so accent-filled buttons use this instead.
  final Color onAccent;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  /// Glassmorphism panel fill/border — tinted dark in dark mode, tinted
  /// dark-on-light (not inverted to white) in light mode so panels still
  /// read as "glass" rather than flat white cards.
  final Color glassFill;
  final Color glassBorder;
  final Color glassBorderHover;
  final Color divider;

  /// Status green used for the "available" badge dot.
  final Color success;

  /// Signature brand gradient — monochromatic (blue → sky-light blue),
  /// used for primary CTAs, the hero name treatment and the portrait
  /// frame. Deliberately a single hue lightened rather than blended with
  /// [secondary]: linearly blending two far-apart hues can pass through a
  /// muddy, desaturated tone in the middle. Lightening one hue never does.
  LinearGradient get primaryGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primary, Color.lerp(primary, const Color(0xFFFFFFFF), 0.45)!],
      );

  RadialGradient glow({double opacity = 0.35, Color? color}) => RadialGradient(
        colors: [
          (color ?? primary).withValues(alpha: opacity),
          (color ?? primary).withValues(alpha: 0),
        ],
      );

  static const AppColors dark = AppColors(
    background: Color(0xFF030209),
    surface: Color(0xFF0D0B14),
    surfaceElevated: Color(0xFF17141F),
    primary: Color(0xFF2F8EFF),
    primaryText: Color(0xFF2F8EFF),
    secondary: Color(0xFF22D3EE),
    onAccent: Color(0xFF0B0A08),
    textPrimary: Color(0xFFF7F6F3),
    textSecondary: Color(0xFFABA8A1),
    textMuted: Color(0xFF7E7B73),
    glassFill: Color(0x0DFFFFFF),
    glassBorder: Color(0x1AFFFFFF),
    glassBorderHover: Color(0x402F8EFF),
    divider: Color(0x14FFFFFF),
    success: Color(0xFF10B981),
  );

  static const AppColors light = AppColors(
    background: Color(0xFFFAF9F7),
    surface: Color(0xFFF2F0EC),
    surfaceElevated: Color(0xFFFFFFFF),
    primary: Color(0xFF2F8EFF),
    primaryText: Color(0xFF0B5FCC),
    secondary: Color(0xFF0E7490),
    onAccent: Color(0xFF0B0A08),
    textPrimary: Color(0xFF1A1712),
    textSecondary: Color(0xFF55524A),
    textMuted: Color(0xFF726F66),
    glassFill: Color(0x08161208),
    glassBorder: Color(0x14161208),
    glassBorderHover: Color(0x400B5FCC),
    divider: Color(0x12161208),
    success: Color(0xFF059669),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? primary,
    Color? primaryText,
    Color? secondary,
    Color? onAccent,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? glassFill,
    Color? glassBorder,
    Color? glassBorderHover,
    Color? divider,
    Color? success,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      primary: primary ?? this.primary,
      primaryText: primaryText ?? this.primaryText,
      secondary: secondary ?? this.secondary,
      onAccent: onAccent ?? this.onAccent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      glassBorderHover: glassBorderHover ?? this.glassBorderHover,
      divider: divider ?? this.divider,
      success: success ?? this.success,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      glassBorderHover: Color.lerp(glassBorderHover, other.glassBorderHover, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}
