import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Full tech stack as chips, plus the authored "why it mattered"
/// decisions where available — grounded entirely in the real stack, no
/// invented architectural claims.
class CsTechnical extends StatelessWidget {
  const CsTechnical({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.techStack.isEmpty) return const SizedBox.shrink();
    return SectionContainer(
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Technical Implementation', title: 'How it was built'),
          const SizedBox(height: 24),
          ScrollReveal(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tech in project.techStack)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    decoration: BoxDecoration(
                      color: context.colors.background,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: context.colors.glassBorder),
                    ),
                    child: Text(
                      tech,
                      style: AppTextStyles.bodySmall(context).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
              ],
            ),
          ),
          if (project.techDecisions.isNotEmpty) ...[
            const SizedBox(height: 28),
            for (int i = 0; i < project.techDecisions.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: i == project.techDecisions.length - 1 ? 0 : 14),
                child: ScrollReveal(
                  delay: Duration(milliseconds: 60 * i),
                  offset: 10,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: GlassCard(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.bolt_rounded, color: context.colors.secondary, size: 18),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.techDecisions[i].title,
                                  style: AppTextStyles.body(context).copyWith(fontWeight: FontWeight.w700, fontSize: 14.5),
                                ),
                                const SizedBox(height: 4),
                                Text(project.techDecisions[i].rationale, style: AppTextStyles.bodySmall(context)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
