import 'package:flutter/material.dart';
import '../theme/app_theme_x.dart';
import 'page_scroll.dart';

/// Thin gradient bar across the top of the body, directly under the
/// navbar, tracking scroll progress for the current page. Listens to
/// [PageScroll] via two small [ValueListenableBuilder]s so only this
/// ~3px strip repaints on scroll — not the page above it.
class ScrollProgressBar extends StatelessWidget {
  const ScrollProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: 2.5,
        child: ValueListenableBuilder<double>(
          valueListenable: PageScroll.offset,
          builder: (context, offset, _) {
            return ValueListenableBuilder<double>(
              valueListenable: PageScroll.maxExtent,
              builder: (context, maxExtent, _) {
                final progress = (offset / maxExtent).clamp(0.0, 1.0);
                return Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(gradient: context.colors.primaryGradient),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
