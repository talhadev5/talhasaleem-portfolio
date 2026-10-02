import '../theme/app_theme_x.dart';
import 'package:flutter/material.dart';

/// Subtle animated glow blobs + grid pattern used behind the hero and
/// other key sections. Kept lightweight to stay tasteful, not distracting.
class GradientBackground extends StatefulWidget {
  const GradientBackground({super.key, this.child, this.intensity = 1.0});

  final Widget? child;
  final double intensity;

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Background layers are Positioned.fill (sized relative to the Stack's
    // resolved size) while `child` is the only non-positioned child, so the
    // Stack sizes itself to the child's intrinsic size. Using
    // `StackFit.expand` here previously forced every child — including
    // `child` — to a tight size; inside a scrollable (unbounded height,
    // e.g. the mobile/tablet hero) that meant an invalid infinite-tight
    // constraint and a blank crashed render.
    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: context.colors.background)),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value;
              return Stack(
                children: [
                  Positioned(
                    top: -100 + (t * 35),
                    right: -80,
                    child: _Blob(
                      color: context.colors.primary.withValues(alpha: 0.20 * widget.intensity),
                      size: 480,
                    ),
                  ),
                  Positioned(
                    bottom: -140,
                    left: -120 - (t * 25),
                    child: _Blob(
                      color: context.colors.secondary.withValues(alpha: 0.18 * widget.intensity),
                      size: 500,
                    ),
                  ),
                  Positioned(
                    top: 180 - (t * 40),
                    right: 40 + (t * 30),
                    child: _Blob(
                      color: context.colors.secondary.withValues(alpha: 0.10 * widget.intensity),
                      size: 320,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Positioned.fill(
          child: CustomPaint(painter: _GridPainter(opacity: 0.03 * widget.intensity)),
        ),
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.opacity});
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: opacity)
      ..strokeWidth = 1;
    const step = 64.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.opacity != opacity;
}
