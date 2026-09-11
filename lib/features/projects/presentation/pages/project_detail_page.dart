import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../domain/entities/project.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final project = ServiceLocator.getProjectById(projectId);

    if (project == null) {
      return Scaffold(
        appBar: const AppNavBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Project not found', style: AppTextStyles.sectionTitle(context)),
              const SizedBox(height: 16),
              SecondaryButton(label: 'Back to Projects', onPressed: () => context.go('/projects')),
            ],
          ),
        ),
      );
    }

    final isDesktop = Responsive.isDesktop(context);
    final allProjects = ServiceLocator.projectRepository.getAllProjects();
    final currentIndex = allProjects.indexWhere((p) => p.id == project.id);
    final nextProject = allProjects.isEmpty
        ? null
        : allProjects[(currentIndex + 1) % allProjects.length];

    return Scaffold(
      appBar: const AppNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _DetailBanner(project: project),
            SectionContainer(
              verticalPadding: 40,
              child: Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: isDesktop ? 7 : 0,
                    child: ScrollReveal(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Overview', style: AppTextStyles.cardTitle),
                          const SizedBox(height: 12),
                          Text(
                            project.description.isNotEmpty ? project.description : 'Add feature details here.',
                            style: AppTextStyles.body,
                          ),
                          const SizedBox(height: 28),
                          Text('Key Features', style: AppTextStyles.cardTitle),
                          const SizedBox(height: 14),
                          if (project.features.isEmpty)
                            Text('Add feature details here.', style: AppTextStyles.body)
                          else
                            ...project.features.map(
                              (feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Icon(Icons.check_circle_rounded, size: 18, color: AppColors.primary),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(feature, style: AppTextStyles.body)),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: isDesktop ? 40 : 0, height: isDesktop ? 0 : 28),
                  Expanded(
                    flex: isDesktop ? 4 : 0,
                    child: ScrollReveal(
                      delay: const Duration(milliseconds: 120),
                      child: GlassCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tech Stack', style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
                            const SizedBox(height: 12),
                            if (project.techStack.isEmpty)
                              Text('Add feature details here.', style: AppTextStyles.bodySmall)
                            else
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: project.techStack
                                    .map((tech) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                          decoration: BoxDecoration(
                                            color: AppColors.background,
                                            borderRadius: BorderRadius.circular(999),
                                            border: Border.all(color: AppColors.glassBorder),
                                          ),
                                          child: Text(tech, style: AppTextStyles.bodySmall),
                                        ))
                                    .toList(),
                              ),
                            const SizedBox(height: 24),
                            Text('Live On', style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
                            const SizedBox(height: 12),
                            if (project.hasNoPublicLink || project.storeLinks.isEmpty)
                              Text(
                                'Showcase project — no public store listing yet.',
                                style: AppTextStyles.bodySmall,
                              )
                            else
                              Column(
                                children: project.storeLinks
                                    .map((link) => Padding(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: PrimaryButton(
                                              label: link.platform == StorePlatform.ios ? 'App Store' : 'Google Play',
                                              icon: link.platform == StorePlatform.ios ? Icons.apple : Icons.android_rounded,
                                              onPressed: () => launchUrl(Uri.parse(link.url), webOnlyWindowName: '_blank'),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (nextProject != null) _NextProjectBar(project: nextProject),
          ],
        ),
      ),
    );
  }
}

class _DetailBanner extends StatelessWidget {
  const _DetailBanner({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Real screenshot goes at assets/images/projects/<id>_banner.jpg —
          // falls back to the branded gradient until it's added.
          Image.asset(
            'assets/images/projects/${project.id}_banner.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const GradientBackground(intensity: 0.7),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.background.withValues(alpha: 0.55), AppColors.background.withValues(alpha: 0.92)],
              ),
            ),
          ),
          SectionContainer(
            verticalPadding: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AnimatedBackLink(),
                const SizedBox(height: 20),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Text(project.category.label.toUpperCase(), style: AppTextStyles.cardSubtitle),
                    _PlatformBadge(label: project.platformLabel),
                  ],
                ),
                const SizedBox(height: 8),
                Text(project.name, style: AppTextStyles.sectionTitle(context)),
              ],
            ),
          ),
        ],
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
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _AnimatedBackLink extends StatefulWidget {
  const _AnimatedBackLink();

  @override
  State<_AnimatedBackLink> createState() => _AnimatedBackLinkState();
}

class _AnimatedBackLinkState extends State<_AnimatedBackLink> {
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
              child: Icon(Icons.arrow_back_rounded, size: 16, color: _hovered ? AppColors.primary : AppColors.textMuted),
            ),
            const SizedBox(width: 6),
            Text(
              'All Projects',
              style: AppTextStyles.bodySmall.copyWith(color: _hovered ? AppColors.primary : AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextProjectBar extends StatefulWidget {
  const _NextProjectBar({required this.project});
  final Project project;

  @override
  State<_NextProjectBar> createState() => _NextProjectBarState();
}

class _NextProjectBarState extends State<_NextProjectBar> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go('/projects/${widget.project.id}'),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceElevated : AppColors.surface,
            border: const Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: SectionContainer(
            verticalPadding: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Next Project', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
                    const SizedBox(height: 4),
                    Text(widget.project.name, style: AppTextStyles.cardTitle),
                  ],
                ),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  offset: _hovered ? const Offset(0.15, 0) : Offset.zero,
                  child: const Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
