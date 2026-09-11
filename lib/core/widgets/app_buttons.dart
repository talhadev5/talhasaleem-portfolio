import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Electric blue/violet gradient CTA with a hover lift + glow, used for primary actions.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isCompact = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isCompact;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: widget.isCompact
              ? const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5)
              : const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF3B82F6), // Electric blue
                Color(0xFF8B5CF6), // Electric violet
              ],
            ),
            borderRadius: BorderRadius.circular(widget.isCompact ? 8 : 12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: _hovered ? 0.45 : 0.24),
                blurRadius: _hovered ? 24 : 14,
                offset: const Offset(0, 4),
              ),
              if (_hovered)
                BoxShadow(
                  color: AppColors.accentBlue.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.button.copyWith(
                  fontSize: widget.isCompact ? 12.0 : 14.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 6),
                Icon(widget.icon, size: widget.isCompact ? 13 : 17, color: Colors.white),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined ghost button used for secondary actions.
/// Minimal, compact, and elegant with subtle violet/blue glow on hover.
class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isCompact = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isCompact;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: widget.isCompact
              ? const EdgeInsets.symmetric(horizontal: 18, vertical: 10)
              : const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.12)
                : AppColors.glassFill,
            borderRadius: BorderRadius.circular(widget.isCompact ? 10 : 12),
            border: Border.all(
              color: _hovered ? AppColors.accentViolet.withValues(alpha: 0.75) : AppColors.glassBorder,
              width: 1.1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accentViolet.withValues(alpha: 0.22),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.button.copyWith(
                  fontSize: widget.isCompact ? 13.5 : 14.5,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  widget.icon,
                  size: widget.isCompact ? 15 : 17,
                  color: _hovered ? AppColors.accentBlue : AppColors.textSecondary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
