import '../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';

/// The same 18 real skills, grouped into themed clusters instead of one
/// flat list — organized for a more "designed" bento layout than a
/// single long wrap of uniform chips.
class _SkillGroup {
  const _SkillGroup(this.title, this.icon, this.skills);
  final String title;
  final IconData icon;
  final List<String> skills;
}

const List<_SkillGroup> _groups = [
  _SkillGroup(
    'Engineering Practices',
    Icons.architecture_rounded,
    ['Flutter', 'Dart', 'Clean Architecture', 'CI/CD Pipelines'],
  ),
  _SkillGroup(
    'State Management',
    Icons.hub_rounded,
    ['BLoC', 'GetX', 'Provider', 'Riverpod'],
  ),
  _SkillGroup(
    'Integrations & Real-time',
    Icons.sync_alt_rounded,
    ['REST API Integration', 'Firebase', 'WebSockets', 'WebRTC', 'Google & Apple Maps'],
  ),
  _SkillGroup(
    'Commerce & AI',
    Icons.auto_awesome_rounded,
    ['In-App Purchases', 'StoreKit / Google Play Billing', 'Stripe', 'PayPal', 'AI/ML Integration'],
  ),
];

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 2);

    return SectionContainer(
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Core Skills',
            title: 'Competencies I bring to every build',
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 20.0;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (int i = 0; i < _groups.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: ScrollReveal(
                        delay: Duration(milliseconds: 90 * i),
                        offset: 16,
                        child: _SkillGroupCard(group: _groups[i]),
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

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group});
  final _SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: context.colors.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(group.icon, color: context.colors.secondary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  group.title,
                  style: AppTextStyles.body(context).copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final skill in group.skills) _SkillChip(label: skill)],
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
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: _hovered ? context.colors.primary.withValues(alpha: 0.14) : context.colors.background,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _hovered ? context.colors.primary : context.colors.glassBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: _hovered ? context.colors.primary : context.colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
