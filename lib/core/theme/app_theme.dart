import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_durations.dart';
import 'app_radii.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => _build(Brightness.dark, AppColors.dark, AppShadows.dark);

  static ThemeData get light => _build(Brightness.light, AppColors.light, AppShadows.light);

  static ThemeData _build(Brightness brightness, AppColors colors, AppShadows shadows) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: colors.background,
      colorScheme: base.colorScheme.copyWith(
        brightness: brightness,
        primary: colors.primary,
        secondary: colors.secondary,
        tertiary: colors.secondary,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        error: const Color(0xFFEF4444),
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      dividerColor: colors.divider,
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: colors.textPrimary,
        displayColor: colors.textPrimary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      extensions: [
        colors,
        AppSpacing.standard,
        AppRadii.standard,
        shadows,
        AppDurations.standard,
      ],
    );
  }
}
