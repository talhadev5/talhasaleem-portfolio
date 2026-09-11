import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../projects/domain/entities/project.dart';
import '../../../projects/presentation/widgets/project_card.dart';

const List<String> _featuredIds = [
  'sympai',
  'roll-off-rolodex',
  'global-wedlock',
  'macrofit',
  'horeca',
  'poul3y',
];

/// Featured Work preview shown on the Home page. Links out to the full
/// filterable Projects page for the complete 16-app catalog.
class ProjectsPreviewSection extends StatelessWidget {
  const ProjectsPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = _featuredIds
        .map((id) => ServiceLocator.projectRepository.getProjectById(id))
        .whereType<Project>()
        .toList();
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 3);
    final vPadding = Responsive.value<double>(context, mobile: 44, tablet: 56, desktop: 68);

    return SectionContainer(
      color: AppColors.surface,
      verticalPadding: vPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Featured Work',
            title: 'A sample of shipped, store-live apps',
            subtitle: '30+ production apps across fintech, health, fleet and commerce. Here are a few.',
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (int i = 0; i < featured.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: ScrollReveal(
                        delay: Duration(milliseconds: 70 * i),
                        child: ProjectCard(project: featured[i]),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          Center(
            child: SecondaryButton(
              label: 'View All Projects',
              icon: Icons.arrow_forward_rounded,
              onPressed: () => context.go('/projects'),
            ),
          ),
        ],
      ),
    );
  }
}
