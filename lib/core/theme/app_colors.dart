import 'package:flutter/material.dart';

/// Central color palette for the premium dark electric blue/violet portfolio theme.
/// Uses deep black/charcoal base, electric blue & violet gradients, subtle ambient glows,
/// and high-contrast typography.
class AppColors {
  AppColors._();

  // Deep black / charcoal base
  static const Color background = Color(0xFF08090D);
  static const Color surface = Color(0xFF0E1017);
  static const Color surfaceElevated = Color(0xFF151824);

  // Electric Blue & Violet Accents
  static const Color primary = Color(0xFF6366F1); // Bright electric indigo/violet-blue
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4338CA);

  static const Color electricBlue = Color(0xFF3B82F6);
  static const Color accentBlue = Color(0xFF38BDF8); // Electric sky/cyan
  static const Color accentViolet = Color(0xFF8B5CF6); // Electric violet

  // Subtle ambient glow colors
  static const Color glowBlue = Color(0xFF3B82F6);
  static const Color glowPurple = Color(0xFF8B5CF6);

  // Typography
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Glassmorphism & borders
  static const Color glassFill = Color(0x0DFFFFFF);
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassBorderHover = Color(0x408B5CF6);
  static const Color divider = Color(0x14FFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3B82F6), // Electric blue
      Color(0xFF8B5CF6), // Electric violet
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF38BDF8),
      Color(0xFF6366F1),
    ],
  );

  static const List<Color> heroGradient = [
    Color(0xFF08090D),
    Color(0xFF0D101E),
    Color(0xFF08090D),
  ];

  static const List<Color> glowGradient = [
    Color(0x553B82F6),
    Color(0x408B5CF6),
    Color(0x00000000),
  ];

  static RadialGradient glow({double opacity = 0.35, Color? color}) => RadialGradient(
        colors: [
          (color ?? primary).withValues(alpha: opacity),
          (color ?? primary).withValues(alpha: 0),
        ],
      );
}
