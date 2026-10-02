import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/projects/presentation/pages/project_detail_page.dart';
import '../../features/projects/presentation/pages/projects_page.dart';
import '../di/service_locator.dart';
import 'seo_page_wrapper.dart';

/// App-wide client-side routing. Each route sets a per-page title/meta
/// description via [SeoPageWrapper] for basic SEO on Flutter Web, and
/// transitions with a Material fade-through (never the default slide).
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => _fadeThroughPage(
          context,
          state,
          const SeoPageWrapper(
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
        pageBuilder: (context, state) => _fadeThroughPage(
          context,
          state,
          const SeoPageWrapper(
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
          final project = ServiceLocator.getProjectById(id);
          final title = project == null ? 'Project — Talha' : '${project.name} — Talha';
          final description = project?.tagline ?? 'Details, features and tech stack for a shipped Flutter project.';
          return _fadeThroughPage(
            context,
            state,
            SeoPageWrapper(
              title: title,
              description: description,
              child: ProjectDetailPage(projectId: id),
            ),
          );
        },
      ),
    ],
  );

  static Page<void> _fadeThroughPage(BuildContext context, GoRouterState state, Widget child) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          fillColor: backgroundColor,
          child: child,
        );
      },
    );
  }
}
