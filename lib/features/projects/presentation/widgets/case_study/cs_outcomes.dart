import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Delivered capabilities and observable product value — never a
/// fabricated metric. Omitted when no outcomes are authored.
class CsOutcomes extends StatelessWidget {
  const CsOutcomes({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.outcomes.isEmpty) return const SizedBox.shrink();
    return SectionContainer(
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Outcomes', title: 'What shipped'),
          const SizedBox(height: 24),
          ScrollReveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final outcome in project.outcomes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.rocket_launch_rounded, color: context.colors.primary, size: 18),
                          const SizedBox(width: 12),
                          Expanded(child: Text(outcome, style: AppTextStyles.body(context))),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
