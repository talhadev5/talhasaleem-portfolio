import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_nav_bar.dart';
import 'cs_section.dart';

/// Desktop: a compact vertical dot-rail, fixed to the viewport (passed
/// into `AppPageScaffold.overlay`) — each dot expands to its label on
/// hover/active, so it stays out of the way of centered page content
/// even at moderate desktop widths.
class CsSectionNavRail extends StatelessWidget {
  const CsSectionNavRail({super.key, required this.sections});

  final List<CsSection> sections;

  @override
  Widget build(BuildContext context) {
    if (sections.length < 2) return const SizedBox.shrink();
    return Positioned(
      right: 16,
      top: 0,
      bottom: 0,
      child: Center(
        child: ValueListenableBuilder<String?>(
          valueListenable: SectionScrollRegistry.activeSection,
          builder: (context, active, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final s in sections) _RailDot(section: s, active: active == s.id),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RailDot extends StatefulWidget {
  const _RailDot({required this.section, required this.active});
  final CsSection section;
  final bool active;

  @override
  State<_RailDot> createState() => _RailDotState();
}

class _RailDotState extends State<_RailDot> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final expanded = _hovered || widget.active;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => SectionScrollRegistry.scrollTo(widget.section.id),
          child: Semantics(
            button: true,
            label: 'Jump to ${widget.section.label}',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(horizontal: expanded ? 10 : 7, vertical: 7),
              decoration: BoxDecoration(
                color: widget.active ? context.colors.primary.withValues(alpha: 0.14) : context.colors.glassFill,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: widget.active ? context.colors.primary.withValues(alpha: 0.5) : context.colors.glassBorder,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.section.icon,
                    size: 13,
                    color: widget.active ? context.colors.primary : context.colors.textMuted,
                  ),
                  if (expanded) ...[
                    const SizedBox(width: 6),
                    Text(
                      widget.section.label,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: widget.active ? context.colors.primary : context.colors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile/tablet: a plain horizontal scrollable chip row, inline in the
/// page content (not fixed — the brief only asks for persistent nav on
/// desktop; mobile just needs to be compact and usable).
class CsSectionNavTabs extends StatelessWidget {
  const CsSectionNavTabs({super.key, required this.sections});

  final List<CsSection> sections;

  @override
  Widget build(BuildContext context) {
    if (sections.length < 2) return const SizedBox.shrink();
    return SizedBox(
      height: 38,
      child: ValueListenableBuilder<String?>(
        valueListenable: SectionScrollRegistry.activeSection,
        builder: (context, active, _) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: sections.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final s = sections[i];
              final isActive = active == s.id;
              return GestureDetector(
                onTap: () => SectionScrollRegistry.scrollTo(s.id),
                child: Semantics(
                  button: true,
                  label: 'Jump to ${s.label}',
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isActive ? context.colors.primary.withValues(alpha: 0.14) : context.colors.glassFill,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: isActive ? context.colors.primary.withValues(alpha: 0.5) : context.colors.glassBorder,
                      ),
                    ),
                    child: Text(
                      s.label,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: isActive ? context.colors.primary : context.colors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
