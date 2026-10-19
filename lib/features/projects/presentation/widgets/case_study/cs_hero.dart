import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/widgets/gradient_background.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../domain/entities/project.dart';
import '../project_link_pills.dart';

/// Case study hero: name, factual summary, category/platform badges,
/// link pills, and a large product visual. Uses the first real
/// screenshot when one exists; otherwise a polished brand cover (never
/// an apologetic "no image" placeholder) built from the same icon/glow
/// treatment used on the project cards, so it reads as intentional.
class CsHero extends StatelessWidget {
  const CsHero({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return ClipRect(
      child: GradientBackground(
        child: SectionContainer(
          verticalPadding: isDesktop ? 72 : 48,
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: isDesktop ? 6 : 0,
                child: ScrollReveal(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _BackLink(),
                      const SizedBox(height: 20),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          Text(project.category.label.toUpperCase(), style: AppTextStyles.cardSubtitle(context)),
                          _PlatformBadge(label: project.platformLabel),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          if (project.logoAssetPath != null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                project.logoAssetPath!,
                                width: 64,
                                height: 64,
                                fit: BoxFit.contain,
                                semanticLabel: '${project.name} app icon',
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          Expanded(child: Text(project.name, style: AppTextStyles.h1(context))),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 540),
                        child: Text(
                          project.tagline,
                          style: AppTextStyles.sectionSubtitle(context),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ProjectLinkPills(project: project, showCaseStudyButton: false),
                    ],
                  ),
                ),
              ),
              SizedBox(width: isDesktop ? 48 : 0, height: isDesktop ? 0 : 36),
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: ScrollReveal(
                  delay: const Duration(milliseconds: 120),
                  child: _CoverVisual(project: project),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Brand cover: app icon, name initial mark, and up to 3 tech chips over
/// a soft glow — the hero visual slot for when no real screenshot
/// exists yet. Swaps automatically for `project.screenshots.first` once
/// real images are added (see `_hasRealCover`).
class _CoverVisual extends StatelessWidget {
  const _CoverVisual({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.screenshots.isNotEmpty) {
      // Real screenshots are almost always tall/portrait; BoxFit.cover inside
      // a 4:3 box would crop most of the screen away. Contain the full
      // screenshot over a brand-gradient backdrop instead, so nothing is lost.
      return AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: context.colors.glassBorder),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [context.colors.surfaceElevated, context.colors.surface],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: context.colors.glow(opacity: 0.25)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(project.screenshots.first.assetPath, fit: BoxFit.contain),
              ),
            ],
          ),
        ),
      );
    }

    final logo = project.logoAssetPath;
    final banner = project.bannerAssetPath;

    if (banner != null) {
      // A real marketing banner, with the brand logo overlaid as a small
      // corner badge so the mark is still identifiable at a glance.
      return AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: context.colors.glassBorder),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [context.colors.surfaceElevated, context.colors.surface],
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(banner, fit: BoxFit.contain),
                ),
              ),
              if (logo != null)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 52,
                    height: 52,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.surfaceElevated,
                      border: Border.all(color: context.colors.glassBorder),
                      boxShadow: context.shadows.card,
                    ),
                    child: ClipOval(child: Image.asset(logo, fit: BoxFit.cover)),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    final initial = project.name.isNotEmpty ? project.name[0].toUpperCase() : '?';
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.colors.glassBorder),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.colors.surfaceElevated, context.colors.surface],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: context.colors.glow(opacity: 0.3)),
            ),
            if (logo != null)
              Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: context.colors.surfaceElevated,
                  border: Border.all(color: context.colors.glassBorder),
                  boxShadow: [BoxShadow(color: context.colors.primary.withValues(alpha: 0.2), blurRadius: 32, offset: const Offset(0, 14))],
                ),
                child: Image.asset(logo, fit: BoxFit.contain),
              )
            else
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: context.colors.primaryGradient,
                  boxShadow: [BoxShadow(color: context.colors.primary.withValues(alpha: 0.35), blurRadius: 32, offset: const Offset(0, 14))],
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: AppTextStyles.display(context).copyWith(fontSize: 48, color: context.colors.onAccent),
                ),
              ),
            if (project.techStack.isNotEmpty)
              Positioned(
                bottom: 22,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tech in project.techStack.take(3))
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: context.colors.surfaceElevated.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: context.colors.glassBorder),
                        ),
                        child: Text(tech, style: AppTextStyles.bodySmall(context)),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlatformBadge extends StatelessWidget {
  const _PlatformBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (label) {
      case 'iOS':
        icon = Icons.apple;
      case 'Android':
        icon = Icons.android_rounded;
      case 'iOS & Android':
        icon = Icons.phone_iphone_rounded;
      default:
        icon = Icons.visibility_outlined;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.glassFill,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: context.colors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: context.colors.textSecondary),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.bodySmall(context)),
        ],
      ),
    );
  }
}

class _BackLink extends StatefulWidget {
  const _BackLink();

  @override
  State<_BackLink> createState() => _BackLinkState();
}

class _BackLinkState extends State<_BackLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go('/projects'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSlide(
              duration: const Duration(milliseconds: 180),
              offset: _hovered ? const Offset(-0.15, 0) : Offset.zero,
              child: Icon(Icons.arrow_back_rounded, size: 16, color: _hovered ? context.colors.primary : context.colors.textMuted),
            ),
            const SizedBox(width: 6),
            Text(
              'All Projects',
              style: AppTextStyles.bodySmall(context).copyWith(color: _hovered ? context.colors.primary : context.colors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
