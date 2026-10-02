import '../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../projects/domain/entities/project.dart';

/// Facts pulled from real content elsewhere on the site (experience,
/// contact, the project catalog's category count) — not duplicating the
/// hero's year/app-count stats, which already cover the headline numbers.
final List<(IconData, String, String)> _facts = [
  (
    Icons.account_tree_rounded,
    'Clean Architecture',
    'BLoC, GetX & Provider patterns',
  ),
  (
    Icons.apps_rounded,
    '${ProjectCategory.values.length} Domains',
    'Fintech, health, fleet, e-commerce & more',
  ),
  (
    Icons.school_rounded,
    'Mentor',
    'Trains developers in modern Flutter practice',
  ),
  (
    Icons.handshake_rounded,
    'Open to work',
    'Freelance & full-time senior roles',
  ),
];

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'About Me',
            title: 'Engineering that ships, not just demos',
          ),
          const SizedBox(height: 32),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: isDesktop ? 7 : 0,
                child: ScrollReveal(
                  delay: const Duration(milliseconds: 100),
                  child: _LeadBio(bio: AppConstants.bio),
                ),
              ),
              SizedBox(width: isDesktop ? 40 : 0, height: isDesktop ? 0 : 28),
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: ScrollReveal(
                  delay: const Duration(milliseconds: 180),
                  child: GlassCard(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < _facts.length; i++) ...[
                          if (i > 0) ...[
                            const SizedBox(height: 16),
                            Container(height: 1, color: context.colors.divider),
                            const SizedBox(height: 16),
                          ],
                          _FactRow(fact: _facts[i]),
                        ],
                      ],
                    ),
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

/// Bio paragraph with its opening clause pulled out as a larger "lead-in"
/// line — an editorial touch (the first sentence as a visual hook) rather
/// than one flat block of body text.
class _LeadBio extends StatelessWidget {
  const _LeadBio({required this.bio});
  final String bio;

  @override
  Widget build(BuildContext context) {
    final splitIndex = bio.indexOf('. ');
    final lead = splitIndex == -1 ? bio : bio.substring(0, splitIndex + 1);
    final rest = splitIndex == -1 ? '' : bio.substring(splitIndex + 2);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lead,
            style: AppTextStyles.h3(context).copyWith(height: 1.4, fontWeight: FontWeight.w600),
          ),
          if (rest.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(rest, style: AppTextStyles.body(context)),
          ],
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.fact});
  final (IconData, String, String) fact;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(fact.$1, color: context.colors.primary, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fact.$2,
                style: AppTextStyles.body(context).copyWith(fontWeight: FontWeight.w700, fontSize: 14.5),
              ),
              const SizedBox(height: 2),
              Text(fact.$3, style: AppTextStyles.bodySmall(context)),
            ],
          ),
        ),
      ],
    );
  }
}
