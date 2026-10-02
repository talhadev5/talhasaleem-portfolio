import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Paired "the problem" / "the solution" cards, side by side on desktop.
/// Renders nothing when either half is missing — kept as a pair rather
/// than showing one without the other.
class CsProblemSolution extends StatelessWidget {
  const CsProblemSolution({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final problem = project.problem;
    final solution = project.solution;
    if (problem == null || solution == null) return const SizedBox.shrink();

    final isDesktop = Responsive.isDesktop(context);
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Problem & Solution', title: 'Why it was built this way'),
          const SizedBox(height: 24),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ScrollReveal(
                  child: _Card(
                    icon: Icons.flag_outlined,
                    label: 'The Problem',
                    text: problem,
                    accentIsPrimary: false,
                  ),
                ),
              ),
              SizedBox(width: isDesktop ? 24 : 0, height: isDesktop ? 0 : 16),
              Expanded(
                child: ScrollReveal(
                  delay: const Duration(milliseconds: 100),
                  child: _Card(
                    icon: Icons.lightbulb_outline_rounded,
                    label: 'The Solution',
                    text: solution,
                    accentIsPrimary: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.icon, required this.label, required this.text, required this.accentIsPrimary});
  final IconData icon;
  final String label;
  final String text;
  final bool accentIsPrimary;

  @override
  Widget build(BuildContext context) {
    final accent = accentIsPrimary ? context.colors.primary : context.colors.secondary;
    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 18),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTextStyles.body(context).copyWith(fontWeight: FontWeight.w700, color: accent),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(text, style: AppTextStyles.body(context)),
        ],
      ),
    );
  }
}
