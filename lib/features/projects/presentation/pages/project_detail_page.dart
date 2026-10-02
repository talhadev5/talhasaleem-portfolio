import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../../../../core/widgets/app_page_scaffold.dart';
import '../../domain/entities/project.dart';
import '../widgets/case_study/cs_challenges.dart';
import '../widgets/case_study/cs_closing.dart';
import '../widgets/case_study/cs_contribution.dart';
import '../widgets/case_study/cs_features.dart';
import '../widgets/case_study/cs_gallery.dart';
import '../widgets/case_study/cs_hero.dart';
import '../widgets/case_study/cs_outcomes.dart';
import '../widgets/case_study/cs_overview.dart';
import '../widgets/case_study/cs_problem_solution.dart';
import '../widgets/case_study/cs_section.dart';
import '../widgets/case_study/cs_section_nav.dart';
import '../widgets/case_study/cs_technical.dart';
import '../widgets/case_study/cs_user_journeys.dart';

/// Full case study for a single project: hero, overview, contribution,
/// problem/solution, features, user journeys, technical implementation,
/// challenges, gallery and outcomes — each section renders nothing when
/// its data is empty, so thinner projects naturally get a shorter page
/// instead of padded filler. Desktop gets a sticky section nav rail;
/// mobile gets an inline scrollable tab row.
class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key, required this.projectId});

  final String projectId;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final Map<String, GlobalKey> _keys = {};

  GlobalKey _keyFor(String id) => _keys.putIfAbsent(id, GlobalKey.new);

  List<CsSection> _sectionsFor(Project project) {
    return [
      const CsSection(id: 'cs-overview', label: 'Overview', icon: Icons.info_outline_rounded),
      if (project.myContribution.isNotEmpty)
        const CsSection(id: 'cs-contribution', label: 'Contribution', icon: Icons.person_outline_rounded),
      if (project.problem != null && project.solution != null)
        const CsSection(id: 'cs-problem', label: 'Problem & Solution', icon: Icons.flag_outlined),
      if (project.features.isNotEmpty) const CsSection(id: 'cs-features', label: 'Features', icon: Icons.star_outline_rounded),
      if (project.userJourneys.isNotEmpty) const CsSection(id: 'cs-journeys', label: 'User Journeys', icon: Icons.route_outlined),
      if (project.techStack.isNotEmpty) const CsSection(id: 'cs-technical', label: 'Technical', icon: Icons.code_rounded),
      if (project.challenges.isNotEmpty) const CsSection(id: 'cs-challenges', label: 'Challenges', icon: Icons.warning_amber_rounded),
      if (project.screenshots.isNotEmpty) const CsSection(id: 'cs-gallery', label: 'Gallery', icon: Icons.photo_library_outlined),
      if (project.outcomes.isNotEmpty) const CsSection(id: 'cs-outcomes', label: 'Outcomes', icon: Icons.rocket_launch_outlined),
    ];
  }

  @override
  void dispose() {
    for (final entry in _keys.entries) {
      SectionScrollRegistry.unregister(entry.key, entry.value);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = ServiceLocator.getProjectById(widget.projectId);

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
    final nextProject = allProjects.isEmpty ? null : allProjects[(currentIndex + 1) % allProjects.length];

    // Re-registering on every build is intentional and cheap: go_router
    // reuses this State when navigating project-to-project (same route
    // pattern, different path param), so initState alone would only run
    // once and go stale for the second project onward.
    final sections = _sectionsFor(project);
    for (final s in sections) {
      SectionScrollRegistry.register(s.id, _keyFor(s.id));
    }

    Widget section(String id, Widget child) => KeyedSubtree(key: _keyFor(id), child: child);

    return AppPageScaffold(
      overlay: isDesktop ? CsSectionNavRail(sections: sections) : null,
      body: Column(
        children: [
          CsHero(project: project),
          if (!isDesktop)
            Padding(
              padding: EdgeInsets.fromLTRB(
                Responsive.pageHorizontalPadding(context).left,
                20,
                Responsive.pageHorizontalPadding(context).right,
                4,
              ),
              child: CsSectionNavTabs(sections: sections),
            ),
          section('cs-overview', CsOverview(project: project)),
          section('cs-contribution', CsContribution(project: project)),
          section('cs-problem', CsProblemSolution(project: project)),
          section('cs-features', CsFeatures(project: project)),
          section('cs-journeys', CsUserJourneys(project: project)),
          section('cs-technical', CsTechnical(project: project)),
          section('cs-challenges', CsChallenges(project: project)),
          section('cs-gallery', CsGallery(project: project)),
          section('cs-outcomes', CsOutcomes(project: project)),
          CsClosing(project: project, nextProject: nextProject),
        ],
      ),
    );
  }
}
