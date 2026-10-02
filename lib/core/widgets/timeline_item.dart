import '../theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_text_styles.dart';
import 'glass_card.dart';

/// Single row in a vertical timeline (dot + connecting line + glass
/// card). Shared by the Experience and Certifications & Leadership
/// sections so both read as one consistent visual language.
class TimelineItem extends StatelessWidget {
  const TimelineItem({super.key, required this.entry, required this.isLast});

  final TimelineEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const _PulsingDot(),
              if (!isLast) Expanded(child: Container(width: 2, color: context.colors.divider)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Text(entry.role, style: AppTextStyles.cardTitle(context).copyWith(fontSize: 17)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: context.colors.primary.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(entry.period, style: AppTextStyles.bodySmall(context).copyWith(color: context.colors.primary)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(entry.organization, style: AppTextStyles.cardSubtitle(context)),
                    const SizedBox(height: 10),
                    ...entry.points.map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Icon(Icons.circle, size: 5, color: context.colors.textMuted),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text(p, style: AppTextStyles.body(context))),
                          ],
                        ),
                      ),
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

/// Timeline dot with a slow breathing glow — a small signal that this
/// row is "live" content rather than a static bullet list.
class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final glow = 0.35 + _ctrl.value * 0.35;
        return Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: context.colors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.colors.primary.withValues(alpha: glow),
                blurRadius: 8 + _ctrl.value * 6,
                spreadRadius: 1 + _ctrl.value * 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
