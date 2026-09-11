import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Type hierarchy for the portfolio. Headlines use Sora for a confident,
/// geometric feel; body copy uses Inter for readability at small sizes.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _sora(double size, FontWeight weight, {Color? color, double? height, double? letterSpacing}) =>
      GoogleFonts.sora(
        fontSize: size,
        fontWeight: weight,
        color: color ?? AppColors.textPrimary,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle _inter(double size, FontWeight weight, {Color? color, double? height, double? letterSpacing}) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color ?? AppColors.textSecondary,
        height: height,
        letterSpacing: letterSpacing,
      );

  // Hero / display
  static TextStyle heroTitle(BuildContext context) => _sora(
        _scale(context, mobile: 40, tablet: 60, desktop: 76),
        FontWeight.w700,
        height: 1.05,
        letterSpacing: -1.5,
      );

  static TextStyle heroSubtitle(BuildContext context) => _inter(
        _scale(context, mobile: 17, tablet: 19, desktop: 21),
        FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  // Section titles
  static TextStyle sectionTitle(BuildContext context) => _sora(
        _scale(context, mobile: 28, tablet: 34, desktop: 42),
        FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.8,
      );

  static TextStyle sectionEyebrow(BuildContext context) => _inter(
        13,
        FontWeight.w600,
        color: AppColors.primary,
        letterSpacing: 3,
      );

  static TextStyle sectionSubtitle(BuildContext context) => _inter(
        _scale(context, mobile: 15, tablet: 16, desktop: 17),
        FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.6,
      );

  // Body / misc
  static TextStyle body = _inter(15, FontWeight.w400, height: 1.7);
  static TextStyle bodySmall = _inter(13, FontWeight.w400, color: AppColors.textMuted, height: 1.6);
  static TextStyle cardTitle = _sora(19, FontWeight.w700);
  static TextStyle cardSubtitle = _inter(13, FontWeight.w500, color: AppColors.primary, letterSpacing: 0.5);
  static TextStyle button = _inter(15, FontWeight.w600, color: AppColors.textPrimary);
  static TextStyle statNumber = _sora(32, FontWeight.w700);
  static TextStyle statLabel = _inter(13, FontWeight.w400, color: AppColors.textMuted);
  static TextStyle navLink = _inter(14, FontWeight.w500, color: AppColors.textSecondary);

  static double _scale(BuildContext context, {required double mobile, required double tablet, required double desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1100) return desktop;
    if (width >= 700) return tablet;
    return mobile;
  }
}
