import '../theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Circular profile photo with a brand-gradient glow ring. Loads
/// [AppConstants.profilePhotoAsset]; falls back to a themed placeholder
/// avatar if the asset is not available.
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
        gradient: context.colors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: context.colors.secondary.withValues(alpha: 0.38),
            blurRadius: 44,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.28),
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
        decoration: BoxDecoration(
          color: context.colors.surface,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.colors.surfaceElevated, context.colors.surface],
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
                  context.colors.primary.withValues(alpha: 0.25),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Icon(
            Icons.person_rounded,
            size: 96,
            color: context.colors.textSecondary,
          ),
        ],
      ),
    );
  }
}
