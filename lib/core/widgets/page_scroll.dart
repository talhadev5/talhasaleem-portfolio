import 'package:flutter/widgets.dart';

/// App-wide scroll state, shared the same way [SectionScrollRegistry]
/// shares section anchors: a plain static registry rather than an
/// InheritedWidget, since the navbar/progress-bar/FAB that need it sit
/// outside the scrollable (as Scaffold.appBar / Stack overlays), not
/// below it in the tree.
///
/// Every page's scrollable attaches its [ScrollController] here (see
/// [AppPageScaffold]) so the navbar can blur-on-scroll, the progress bar
/// can track position, and the scroll-to-top FAB can act on it —
/// regardless of which page is currently mounted.
class PageScroll {
  PageScroll._();

  static final ValueNotifier<double> offset = ValueNotifier(0);
  static final ValueNotifier<double> maxExtent = ValueNotifier(1);

  static ScrollController? _controller;

  static void attach(ScrollController controller) {
    _controller = controller;
  }

  static void detach(ScrollController controller) {
    if (identical(_controller, controller)) {
      _controller = null;
      offset.value = 0;
      maxExtent.value = 1;
    }
  }

  static void update(ScrollController controller) {
    if (!identical(_controller, controller) || !controller.hasClients) return;
    offset.value = controller.offset;
    maxExtent.value = controller.position.maxScrollExtent <= 0 ? 1 : controller.position.maxScrollExtent;
  }

  static Future<void> scrollToTop() async {
    final controller = _controller;
    if (controller == null || !controller.hasClients) return;
    await controller.animateTo(0, duration: const Duration(milliseconds: 700), curve: Curves.easeOutCubic);
  }
}
