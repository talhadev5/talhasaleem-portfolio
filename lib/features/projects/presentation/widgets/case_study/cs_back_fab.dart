import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_theme_x.dart';
import '../../../../../core/widgets/page_scroll.dart';

/// Sticky "back to projects" button, top-left — fades/slides in once the
/// hero's own back link has scrolled out of view, mirroring
/// [ScrollToTopFab]'s reveal behavior on the opposite corner, so the case
/// study is never more than one tap from the projects grid.
class CsBackFab extends StatelessWidget {
  const CsBackFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 88,
      left: 24,
      child: ValueListenableBuilder<double>(
        valueListenable: PageScroll.offset,
        builder: (context, offset, _) {
          final visible = offset > 420;
          return IgnorePointer(
            ignoring: !visible,
            child: AnimatedSlide(
              duration: context.motion(context.durations.fast),
              curve: Curves.easeOutCubic,
              offset: visible ? Offset.zero : const Offset(-0.3, 0),
              child: AnimatedOpacity(
                duration: context.motion(context.durations.fast),
                opacity: visible ? 1 : 0,
                child: _BackButton(onTap: () => context.go('/projects')),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BackButton extends StatefulWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Back to all projects',
      child: Tooltip(
        message: 'Back to all projects',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: context.motion(context.durations.fast),
              curve: Curves.easeOut,
              height: 44,
              transform: Matrix4.translationValues(_hovered ? -3 : 0, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colors.surfaceElevated.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: _hovered ? context.colors.primary.withValues(alpha: 0.5) : context.colors.glassBorder,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: _hovered ? 22 : 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_rounded, size: 16, color: context.colors.textPrimary),
                  const SizedBox(width: 8),
                  Text(
                    'All Projects',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: context.colors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
