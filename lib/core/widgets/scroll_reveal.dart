import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps a child and plays a fade + slide-up reveal animation the first
/// time it scrolls into view. Subsequent scrolls don't re-trigger it.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 32,
    this.duration = const Duration(milliseconds: 700),
  });

  final Widget child;
  final Duration delay;
  final double offset;
  final Duration duration;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _visible = false;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0.12) {
          setState(() => _visible = true);
        }
      },
      child: _visible
          ? widget.child
              .animate(delay: widget.delay)
              .fadeIn(duration: widget.duration, curve: Curves.easeOutCubic)
              .slideY(begin: widget.offset / 100, end: 0, duration: widget.duration, curve: Curves.easeOutCubic)
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}
