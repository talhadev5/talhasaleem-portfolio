import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

/// Circular profile photo with an electric blue & violet gradient glow ring.
/// Loads [AppConstants.profilePhotoAsset]; falls back to an electric-themed
/// placeholder avatar if the asset is not available.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.size = 220});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF38BDF8), // Electric cyan/blue
            Color(0xFF8B5CF6), // Electric violet
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowBlue.withValues(alpha: 0.38),
            blurRadius: 44,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.glowPurple.withValues(alpha: 0.28),
            blurRadius: 84,
            spreadRadius: 8,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.65),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(3.5),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            AppConstants.profilePhotoAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const _PlaceholderAvatar(),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderAvatar extends StatelessWidget {
  const _PlaceholderAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E1B4B), // Deep indigo
            Color(0xFF0F172A), // Deep slate/black
            Color(0xFF1E293B),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.25),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const Icon(
            Icons.person_rounded,
            size: 96,
            color: Color(0xFFC7D2FE), // Soft electric lavender
          ),
        ],
      ),
    );
  }
}
