import '../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/project.dart';

/// External/store links for a project, plus an optional prominent
/// "View Case Study" pill — reused on both [ProjectCard] and the case
/// study page itself. Only emits a pill for a link that actually exists
/// on [project]; never a disabled/empty placeholder.
///
/// Deliberately a sibling of whatever triggers card navigation, never a
/// descendant of it — see `ProjectCard` for why: nesting two tappable
/// regions risks both firing, so the card's nav `GestureDetector` only
/// wraps the non-interactive content above this row.
class ProjectLinkPills extends StatelessWidget {
  const ProjectLinkPills({
    super.key,
    required this.project,
    this.showCaseStudyButton = true,
    this.dense = false,
  });

  final Project project;
  final bool showCaseStudyButton;
  final bool dense;

  List<(IconData, String, String)> get _links {
    final out = <(IconData, String, String)>[];
    for (final link in project.storeLinks) {
      out.add(
        link.platform == StorePlatform.ios
            ? (Icons.apple, 'App Store', link.url)
            : (Icons.shop_rounded, 'Google Play', link.url),
      );
    }
    if (project.websiteUrl != null) {
      out.add((Icons.language_rounded, 'Website', project.websiteUrl!));
    }
    if (project.githubUrl != null) {
      out.add((SimpleIcons.github, 'GitHub', project.githubUrl!));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final links = _links;
    if (links.isEmpty && !showCaseStudyButton) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final l in links) _LinkPill(icon: l.$1, label: l.$2, url: l.$3, dense: dense),
        if (showCaseStudyButton) _CaseStudyPill(projectId: project.id, dense: dense),
      ],
    );
  }
}

class _LinkPill extends StatefulWidget {
  const _LinkPill({required this.icon, required this.label, required this.url, required this.dense});
  final IconData icon;
  final String label;
  final String url;
  final bool dense;

  @override
  State<_LinkPill> createState() => _LinkPillState();
}

class _LinkPillState extends State<_LinkPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: '${widget.label} (opens in a new tab)',
      child: Tooltip(
        message: '${widget.label} ↗',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => launchUrl(Uri.parse(widget.url), webOnlyWindowName: '_blank'),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(horizontal: widget.dense ? 9 : 11, vertical: widget.dense ? 6 : 7),
              decoration: BoxDecoration(
                color: _hovered ? context.colors.primary.withValues(alpha: 0.12) : context.colors.glassFill,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: _hovered ? context.colors.primary.withValues(alpha: 0.6) : context.colors.glassBorder,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: widget.dense ? 13 : 14, color: _hovered ? context.colors.primary : context.colors.textSecondary),
                  const SizedBox(width: 6),
                  Text(
                    widget.label,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontSize: widget.dense ? 11 : 11.5,
                      fontWeight: FontWeight.w600,
                      color: _hovered ? context.colors.primary : context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CaseStudyPill extends StatefulWidget {
  const _CaseStudyPill({required this.projectId, required this.dense});
  final String projectId;
  final bool dense;

  @override
  State<_CaseStudyPill> createState() => _CaseStudyPillState();
}

class _CaseStudyPillState extends State<_CaseStudyPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: 'View full case study',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.go('/projects/${widget.projectId}'),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: widget.dense ? 10 : 12, vertical: widget.dense ? 6 : 7),
            decoration: BoxDecoration(
              gradient: context.colors.primaryGradient,
              borderRadius: BorderRadius.circular(999),
              boxShadow: _hovered
                  ? [BoxShadow(color: context.colors.primary.withValues(alpha: 0.35), blurRadius: 14, offset: const Offset(0, 4))]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Case Study',
                  style: AppTextStyles.bodySmall(context).copyWith(
                    fontSize: widget.dense ? 11 : 11.5,
                    fontWeight: FontWeight.w700,
                    color: context.colors.onAccent,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(Icons.arrow_outward_rounded, size: widget.dense ? 12 : 13, color: context.colors.onAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
