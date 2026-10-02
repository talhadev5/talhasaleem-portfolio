import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Screenshot gallery in device-style frames, with an accessible
/// full-screen viewer (Escape to close, arrow keys to navigate).
/// Renders nothing when the project has no real screenshots yet —
/// never a row of placeholder boxes. Preserves each image's own aspect
/// ratio (`BoxFit.contain`) rather than cropping to a fixed frame shape.
class CsGallery extends StatelessWidget {
  const CsGallery({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.screenshots.isEmpty) return const SizedBox.shrink();
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      child: ScrollReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(eyebrow: 'Gallery', title: 'A closer look'),
            const SizedBox(height: 20),
            SizedBox(
              height: isMobile ? 380 : 460,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: project.screenshots.length,
                separatorBuilder: (_, _) => const SizedBox(width: 18),
                itemBuilder: (context, index) => _FrameThumb(
                  project: project,
                  index: index,
                  isMobile: isMobile,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FrameThumb extends StatefulWidget {
  const _FrameThumb({required this.project, required this.index, required this.isMobile});
  final Project project;
  final int index;
  final bool isMobile;

  @override
  State<_FrameThumb> createState() => _FrameThumbState();
}

class _FrameThumbState extends State<_FrameThumb> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final shot = widget.project.screenshots[widget.index];
    final width = widget.isMobile ? 220.0 : 260.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => showGalleryViewer(context, project: widget.project, initialIndex: widget.index),
        child: Semantics(
          button: true,
          label: 'Open full-screen: ${shot.caption}',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _hovered ? context.colors.primary.withValues(alpha: 0.5) : context.colors.glassBorder,
                width: 1.4,
              ),
              color: context.colors.surfaceElevated,
              boxShadow: _hovered ? context.shadows.cardHover : context.shadows.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                    child: Container(
                      color: context.colors.background,
                      alignment: Alignment.center,
                      child: Image.asset(shot.assetPath, fit: BoxFit.contain),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    shot.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Opens the accessible full-screen viewer for [project]'s screenshots,
/// starting at [initialIndex].
void showGalleryViewer(BuildContext context, {required Project project, required int initialIndex}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black87,
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: _GalleryViewer(project: project, initialIndex: initialIndex),
      ),
    ),
  );
}

class _GalleryViewer extends StatefulWidget {
  const _GalleryViewer({required this.project, required this.initialIndex});
  final Project project;
  final int initialIndex;

  @override
  State<_GalleryViewer> createState() => _GalleryViewerState();
}

class _GalleryViewerState extends State<_GalleryViewer> {
  late int _index;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _next() => setState(() => _index = (_index + 1) % widget.project.screenshots.length);
  void _prev() => setState(() => _index = (_index - 1 + widget.project.screenshots.length) % widget.project.screenshots.length);

  @override
  Widget build(BuildContext context) {
    final shots = widget.project.screenshots;
    final shot = shots[_index];
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is! KeyDownEvent) return;
        switch (event.logicalKey) {
          case LogicalKeyboardKey.escape:
            Navigator.of(context).pop();
          case LogicalKeyboardKey.arrowRight:
            if (shots.length > 1) _next();
          case LogicalKeyboardKey.arrowLeft:
            if (shots.length > 1) _prev();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Hero(
                    tag: shot.assetPath,
                    child: Image.asset(shot.assetPath, fit: BoxFit.contain),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: Center(
                  child: Text(
                    shot.caption,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Semantics(
                  button: true,
                  label: 'Close',
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              if (shots.length > 1) ...[
                Positioned(
                  left: 4,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Semantics(
                      button: true,
                      label: 'Previous screenshot',
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 32),
                        onPressed: _prev,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Semantics(
                      button: true,
                      label: 'Next screenshot',
                      child: IconButton(
                        icon: const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 32),
                        onPressed: _next,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
