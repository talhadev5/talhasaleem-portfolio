import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Engineering challenges the real feature set genuinely implies, paired
/// with how the app addresses them. Omitted entirely for projects where
/// this can't be honestly grounded in existing data.
class CsChallenges extends StatelessWidget {
  const CsChallenges({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.challenges.isEmpty) return const SizedBox.shrink();
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Challenges & Solutions', title: 'Engineering it right'),
          const SizedBox(height: 24),
          for (int i = 0; i < project.challenges.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == project.challenges.length - 1 ? 0 : 16),
              child: ScrollReveal(
                delay: Duration(milliseconds: 80 * i),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.warning_amber_rounded, color: context.colors.secondary, size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(project.challenges[i].challenge, style: AppTextStyles.body(context).copyWith(fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.check_circle_rounded, color: context.colors.primary, size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(project.challenges[i].solution, style: AppTextStyles.body(context)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
