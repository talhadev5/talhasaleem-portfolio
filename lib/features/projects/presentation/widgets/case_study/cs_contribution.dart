import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Role and responsibilities — renders nothing if the project has no
/// authored contribution statement.
class CsContribution extends StatelessWidget {
  const CsContribution({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.myContribution.isEmpty) return const SizedBox.shrink();
    return SectionContainer(
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'My Contribution', title: 'What I built'),
          const SizedBox(height: 24),
          ScrollReveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: GlassCard(
                padding: const EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.person_rounded, color: context.colors.primary, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(project.myContribution, style: AppTextStyles.body(context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
