import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme_x.dart';

/// Type hierarchy for the portfolio. Headlines use Sora for a confident,
/// geometric feel; body copy uses Inter for readability at small sizes.
///
/// Every style is a method taking [BuildContext] (not a static field) so
/// its default color can come from `context.colors` and stay reactive to
/// theme changes — the same reason [AppColors] moved off static consts.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _sora(
    BuildContext context,
    double size,
    FontWeight weight, {
    Color? color,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.sora(
        fontSize: size,
        fontWeight: weight,
        color: color ?? context.colors.textPrimary,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle _inter(
    BuildContext context,
    double size,
    FontWeight weight, {
    Color? color,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color ?? context.colors.textSecondary,
        height: height,
        letterSpacing: letterSpacing,
      );

  // Display / hero
  static TextStyle display(BuildContext context) => _sora(
        context,
        _scale(context, mobile: 44, tablet: 64, desktop: 80),
        FontWeight.w700,
        height: 1.02,
        letterSpacing: -1.8,
      );

  static TextStyle heroTitle(BuildContext context) => _sora(
        context,
        _scale(context, mobile: 40, tablet: 60, desktop: 76),
        FontWeight.w700,
        height: 1.05,
        letterSpacing: -1.5,
      );

  static TextStyle heroSubtitle(BuildContext context) => _inter(
        context,
        _scale(context, mobile: 17, tablet: 19, desktop: 21),
        FontWeight.w400,
        height: 1.5,
      );

  // Headings
  static TextStyle h1(BuildContext context) => _sora(
        context,
        _scale(context, mobile: 32, tablet: 40, desktop: 48),
        FontWeight.w700,
        height: 1.12,
        letterSpacing: -1.0,
      );

  static TextStyle h2(BuildContext context) => _sora(
        context,
        _scale(context, mobile: 26, tablet: 32, desktop: 36),
        FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.6,
      );

  static TextStyle h3(BuildContext context) => _sora(
        context,
        _scale(context, mobile: 20, tablet: 23, desktop: 24),
        FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.2,
      );

  static TextStyle sectionTitle(BuildContext context) => _sora(
        context,
        _scale(context, mobile: 28, tablet: 34, desktop: 42),
        FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.8,
      );

  static TextStyle sectionEyebrow(BuildContext context) => _inter(
        context,
        13,
        FontWeight.w600,
        color: context.colors.primaryText,
        letterSpacing: 3,
      );

  static TextStyle sectionSubtitle(BuildContext context) => _inter(
        context,
        _scale(context, mobile: 15, tablet: 16, desktop: 17),
        FontWeight.w400,
        height: 1.6,
      );

  // Body / misc — body line-height stays >=1.5 for readability per the
  // design brief.
  static TextStyle body(BuildContext context) => _inter(context, 16, FontWeight.w400, height: 1.65);
  static TextStyle bodySmall(BuildContext context) =>
      _inter(context, 13.5, FontWeight.w400, color: context.colors.textMuted, height: 1.6);
  static TextStyle caption(BuildContext context) =>
      _inter(context, 12, FontWeight.w500, color: context.colors.textMuted, height: 1.5, letterSpacing: 0.2);
  static TextStyle mono(BuildContext context) =>
      GoogleFonts.robotoMono(fontSize: 13, color: context.colors.textPrimary, height: 1.5);

  static TextStyle cardTitle(BuildContext context) => _sora(context, 19, FontWeight.w700);
  static TextStyle cardSubtitle(BuildContext context) =>
      _inter(context, 13, FontWeight.w500, color: context.colors.primaryText, letterSpacing: 0.5);
  static TextStyle button(BuildContext context) =>
      _inter(context, 15, FontWeight.w600, color: context.colors.textPrimary);
  static TextStyle statNumber(BuildContext context) => _sora(context, 32, FontWeight.w700);
  static TextStyle statLabel(BuildContext context) =>
      _inter(context, 13, FontWeight.w400, color: context.colors.textMuted);
  static TextStyle navLink(BuildContext context) =>
      _inter(context, 14, FontWeight.w500, color: context.colors.textSecondary);

  static double _scale(BuildContext context, {required double mobile, required double tablet, required double desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return desktop;
    if (width >= 600) return tablet;
    return mobile;
  }
}
