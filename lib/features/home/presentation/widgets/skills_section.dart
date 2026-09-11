import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';

/// Flat, uniform-chip list of technical competencies. Kept separate
/// from [ToolsSection] (which is editors/platforms, not skills).
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Core Skills',
            title: 'Competencies I bring to every build',
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (int i = 0; i < AppConstants.coreSkills.length; i++)
                ScrollReveal(
                  delay: Duration(milliseconds: 25 * i),
                  offset: 12,
                  child: _SkillChip(label: AppConstants.coreSkills[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.label});
  final String label;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.primary.withValues(alpha: 0.14) : AppColors.background,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _hovered ? AppColors.primary : AppColors.glassBorder),
        ),
        // Row + mainAxisSize.min (not Container's `alignment`) centers the
        // label vertically without the container expanding to fill the
        // Wrap's bounded width — that's what kept every chip full-width.
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: AppTextStyles.bodySmall.copyWith(
                color: _hovered ? AppColors.primary : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
