import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/project.dart';

/// Fixed-height project tile used in both the home "Featured Work"
/// preview and the full filterable Projects grid — every card is the
/// same width/height regardless of content, so the grid stays aligned.
/// Hover lifts, scales slightly and glows; tap opens the detail page.
class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  static const double height = 240;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go('/projects/${project.id}'),
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
                        color: AppColors.primary.withValues(alpha: 0.28),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ]
                  : [],
            ),
            child: GlassCard(
              padding: const EdgeInsets.all(20),
              borderColor: _hovered
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.glassBorder,
              fillColor: _hovered
                  ? AppColors.surfaceElevated.withValues(alpha: 0.8)
                  : AppColors.surfaceElevated.withValues(alpha: 0.45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _AppIconPlaceholder(name: project.name, hovered: _hovered),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.accentBlue.withValues(alpha: 0.22),
                          ),
                        ),
                        child: Text(
                          project.category.label.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                            color: AppColors.accentBlue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ...project.storeLinks.map((link) => Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              link.platform == StorePlatform.ios
                                  ? Icons.apple
                                  : Icons.android_rounded,
                              size: 17,
                              color: AppColors.textMuted,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    project.name,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      project.tagline,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13.5,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'View details',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: _hovered ? AppColors.primary : AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 220),
                        offset: _hovered ? const Offset(0.2, 0) : Offset.zero,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 15,
                          color: _hovered ? AppColors.primary : AppColors.textMuted,
                        ),
                      ),
                    ],
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

class _AppIconPlaceholder extends StatelessWidget {
  const _AppIconPlaceholder({required this.name, required this.hovered});
  final String name;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: hovered ? 0.95 : 0.75),
            AppColors.primaryDark.withValues(alpha: hovered ? 0.95 : 0.75),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: AppTextStyles.cardTitle.copyWith(fontSize: 19, color: Colors.white),
      ),
    );
  }
}
