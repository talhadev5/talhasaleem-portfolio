import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/projects/presentation/pages/project_detail_page.dart';
import '../../features/projects/presentation/pages/projects_page.dart';
import 'seo_page_wrapper.dart';

/// App-wide client-side routing. Each route sets a per-page title/meta
/// description via [SeoPageWrapper] for basic SEO on Flutter Web.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SeoPageWrapper(
            title: 'Talha — Senior Flutter Developer',
            description:
                'Senior Flutter Developer with 4+ years of experience and 30+ production apps shipped '
                'across fintech, health, fleet and e-commerce.',
            child: HomePage(),
          ),
        ),
      ),
      GoRoute(
        path: '/projects',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SeoPageWrapper(
            title: 'Projects — Talha',
            description: 'Browse 30+ shipped Flutter apps across fintech, eCommerce, health, fleet and lifestyle.',
            child: ProjectsPage(),
          ),
        ),
      ),
      GoRoute(
        path: '/projects/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: SeoPageWrapper(
              title: 'Project — Talha',
              description: 'Details, features and tech stack for a shipped Flutter project.',
              child: ProjectDetailPage(projectId: id),
            ),
          );
        },
      ),
    ],
  );
}
