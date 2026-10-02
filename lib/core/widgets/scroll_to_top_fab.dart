import 'package:flutter/material.dart';
import '../theme/app_theme_x.dart';
import 'page_scroll.dart';

/// Fades/scales in once the page has been scrolled past roughly one
/// viewport, and smoothly scrolls back to top on tap.
class ScrollToTopFab extends StatelessWidget {
  const ScrollToTopFab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewportHeight = MediaQuery.sizeOf(context).height;
    return ValueListenableBuilder<double>(
      valueListenable: PageScroll.offset,
      builder: (context, offset, _) {
        final visible = offset > viewportHeight * 0.8;
        return IgnorePointer(
          ignoring: !visible,
          child: AnimatedSlide(
            duration: context.motion(context.durations.fast),
            curve: Curves.easeOutCubic,
            offset: visible ? Offset.zero : const Offset(0, 0.3),
            child: AnimatedOpacity(
              duration: context.motion(context.durations.fast),
              opacity: visible ? 1 : 0,
              child: _FabButton(onTap: PageScroll.scrollToTop),
            ),
          ),
        );
      },
    );
  }
}

class _FabButton extends StatefulWidget {
  const _FabButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<_FabButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Scroll to top',
      child: Tooltip(
        message: 'Scroll to top',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: context.motion(context.durations.fast),
              curve: Curves.easeOut,
              width: 44,
              height: 44,
              transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
              decoration: BoxDecoration(
                gradient: context.colors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.colors.primary.withValues(alpha: _hovered ? 0.45 : 0.28),
                    blurRadius: _hovered ? 22 : 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_upward_rounded, color: context.colors.onAccent, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
