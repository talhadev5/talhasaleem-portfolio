import '../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/project.dart';
import 'project_link_pills.dart';

/// Fixed-height project tile used in both the home "Featured Work"
/// preview and the full filterable Projects grid — every card is the
/// same width/height regardless of content, so the grid stays aligned.
/// Hover lifts, scales slightly and glows.
///
/// Only the icon/title/description zone navigates to the case study —
/// the link pills below are a sibling, not a descendant, of that tap
/// target, so tapping a store/website/GitHub link can never also
/// trigger card navigation (see [ProjectLinkPills]).
class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, this.featured = false});

  final Project project;

  /// Richer presentation for the bento-grid "spotlight" slot: bigger
  /// icon/title, description instead of the one-line tagline, and a
  /// couple of tech-stack chips. Same real data either way.
  final bool featured;

  static const double height = 300;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final featured = widget.featured;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        scale: _hovered ? 1.018 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
          height: ProjectCard.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: context.colors.primary.withValues(alpha: 0.28),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : [],
          ),
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            borderColor: _hovered ? context.colors.primary.withValues(alpha: 0.5) : context.colors.glassBorder,
            fillColor: _hovered
                ? context.colors.surfaceElevated.withValues(alpha: 0.8)
                : context.colors.surfaceElevated.withValues(alpha: 0.45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => context.go('/projects/${project.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _AppIconPlaceholder(name: project.name, hovered: _hovered, featured: featured),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: context.colors.secondary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: context.colors.secondary.withValues(alpha: 0.22)),
                              ),
                              child: Text(
                                project.category.label.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.7,
                                  color: context.colors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          project.name,
                          style: AppTextStyles.cardTitle(context).copyWith(fontSize: featured ? 21 : 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            featured ? project.description : project.tagline,
                            style: AppTextStyles.body(context).copyWith(
                              fontSize: 13.5,
                              color: context.colors.textSecondary,
                              height: 1.45,
                            ),
                            maxLines: featured ? 3 : 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ProjectLinkPills(project: project, dense: !featured),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppIconPlaceholder extends StatelessWidget {
  const _AppIconPlaceholder({required this.name, required this.hovered, this.featured = false});
  final String name;
  final bool hovered;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final size = featured ? 56.0 : 48.0;
    return Semantics(
      label: '$name app icon',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: context.colors.primaryGradient.colors.map((c) => c.withValues(alpha: hovered ? 0.95 : 0.75)).toList(),
          ),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.smartphone_rounded, size: featured ? 26 : 22, color: context.colors.onAccent),
      ),
    );
  }
}
