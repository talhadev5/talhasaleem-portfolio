import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/project.dart';
import '../bloc/projects_bloc.dart';
import '../widgets/category_filter_chip.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectsBloc(ServiceLocator.getProjects)..add(const ProjectsRequested()),
      child: const _ProjectsView(),
    );
  }
}

class _ProjectsView extends StatelessWidget {
  const _ProjectsView();

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 3);

    return Scaffold(
      appBar: const AppNavBar(),
      body: SingleChildScrollView(
        child: SectionContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: 'Work',
                title: 'All Projects',
                subtitle: '30+ apps shipped to the App Store and Google Play across fintech, health, '
                    'fleet, commerce and lifestyle domains.',
              ),
              const SizedBox(height: 24),
              const _CategoryFilters(),
              const SizedBox(height: 28),
              BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  if (state.filteredProjects.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      child: Center(child: Text('No projects in this category yet.', style: TextStyle(color: AppColors.textMuted))),
                    );
                  }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      const gap = 20.0;
                      final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          for (int i = 0; i < state.filteredProjects.length; i++)
                            SizedBox(
                              width: cardWidth,
                              child: ScrollReveal(
                                delay: Duration(milliseconds: 40 * (i % columns)),
                                child: ProjectCard(project: state.filteredProjects[i]),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  const _CategoryFilters();

  @override
  Widget build(BuildContext context) {
    final selected = context.select((ProjectsBloc bloc) => bloc.state.selectedCategory);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        CategoryFilterChip(
          label: 'All',
          selected: selected == null,
          onTap: () => context.read<ProjectsBloc>().add(const ProjectsCategoryChanged(null)),
        ),
        for (final category in ProjectCategory.values)
          CategoryFilterChip(
            label: category.label,
            selected: selected == category,
            onTap: () => context.read<ProjectsBloc>().add(ProjectsCategoryChanged(category)),
          ),
      ],
    );
  }
}
