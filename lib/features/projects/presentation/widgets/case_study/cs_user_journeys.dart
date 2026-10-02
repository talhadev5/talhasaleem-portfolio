import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Main workflows (booking, tracking, admin review, etc.), as numbered
/// steps — only rendered for the projects where a real journey is
/// authored; omitted entirely otherwise.
class CsUserJourneys extends StatelessWidget {
  const CsUserJourneys({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.userJourneys.isEmpty) return const SizedBox.shrink();
    final columns = Responsive.value(context, mobile: 1, tablet: 1, desktop: project.userJourneys.length > 1 ? 2 : 1);

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'User Journeys', title: 'Main workflows'),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 20.0;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (int i = 0; i < project.userJourneys.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: ScrollReveal(
                        delay: Duration(milliseconds: 80 * i),
                        child: _JourneyCard(journey: project.userJourneys[i]),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({required this.journey});
  final UserJourney journey;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            journey.title,
            style: AppTextStyles.body(context).copyWith(fontWeight: FontWeight.w700, fontSize: 15.5),
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < journey.steps.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == journey.steps.length - 1 ? 0 : 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.primary.withValues(alpha: 0.14),
                    ),
                    child: Text(
                      '${i + 1}',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(journey.steps[i], style: AppTextStyles.body(context).copyWith(fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
