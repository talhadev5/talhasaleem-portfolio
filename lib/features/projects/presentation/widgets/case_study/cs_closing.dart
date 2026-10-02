import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_buttons.dart';
import '../../../../../core/widgets/app_nav_bar.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../domain/entities/project.dart';
import '../project_link_pills.dart';

/// Closing: links again, a contact CTA, and a next-project link.
class CsClosing extends StatelessWidget {
  const CsClosing({super.key, required this.project, this.nextProject});

  final Project project;
  final Project? nextProject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionContainer(
          color: context.colors.surface,
          child: ScrollReveal(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Interested in a project like this?', style: AppTextStyles.h3(context), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text(
                  'Have a Flutter app to build, scale or rescue? I\'d love to hear about it.',
                  style: AppTextStyles.sectionSubtitle(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Discuss Your Project',
                  icon: Icons.mail_outline_rounded,
                  onPressed: () {
                    if (GoRouterState.of(context).uri.path != '/') {
                      context.go('/#contact');
                    } else {
                      SectionScrollRegistry.scrollTo('contact');
                    }
                  },
                ),
                const SizedBox(height: 28),
                ProjectLinkPills(project: project, showCaseStudyButton: false),
              ],
            ),
          ),
        ),
        if (nextProject != null) _NextProjectBar(project: nextProject!),
      ],
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
            color: _hovered ? context.colors.surfaceElevated : context.colors.background,
            border: Border(top: BorderSide(color: context.colors.divider)),
          ),
          child: SectionContainer(
            verticalPadding: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Next Project', style: AppTextStyles.bodySmall(context).copyWith(color: context.colors.primary)),
                    const SizedBox(height: 4),
                    Text(widget.project.name, style: AppTextStyles.cardTitle(context)),
                  ],
                ),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  offset: _hovered ? const Offset(0.15, 0) : Offset.zero,
                  child: Icon(Icons.arrow_forward_rounded, color: context.colors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
