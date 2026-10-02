import 'package:flutter/material.dart';
import 'app_nav_bar.dart';
import 'page_scroll.dart';
import 'scroll_progress_bar.dart';
import 'scroll_to_top_fab.dart';

/// Standard page shell shared by every route: sticky [AppNavBar], a
/// scrollable body wired into [PageScroll] (so the navbar can blur on
/// scroll and the active-section indicator can track position), a scroll
/// progress bar directly under the navbar, and a scroll-to-top FAB.
///
/// Replaces the `Scaffold(appBar: AppNavBar(), body: SingleChildScrollView(...))`
/// boilerplate that was duplicated identically across the Home, Projects
/// and Project Detail pages.
class AppPageScaffold extends StatefulWidget {
  const AppPageScaffold({super.key, required this.body, this.overlay});

  final Widget body;

  /// Optional extra layer positioned outside the scrollable, alongside
  /// the progress bar/FAB — e.g. a case study page's sticky section nav.
  /// Most pages leave this null.
  final Widget? overlay;

  @override
  State<AppPageScaffold> createState() => _AppPageScaffoldState();
}

class _AppPageScaffoldState extends State<AppPageScaffold> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Reset on every new page mount — only Home registers section anchors,
    // so without this a page without sections (Projects, Project Detail)
    // would keep showing whichever Home section was last active. Harmless
    // for Home itself: the first scroll tick recomputes it correctly.
    SectionScrollRegistry.activeSection.value = null;
    PageScroll.attach(_scrollController);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    PageScroll.update(_scrollController);
    SectionScrollRegistry.updateActiveSection(_scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    PageScroll.detach(_scrollController);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: widget.body,
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ScrollProgressBar(),
          ),
          const Positioned(bottom: 24, right: 24, child: ScrollToTopFab()),
          if (widget.overlay != null) widget.overlay!,
        ],
      ),
    );
  }
}
