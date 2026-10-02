import 'dart:math' as math;

import '../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_icons/simple_icons.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/gradient_background.dart';

/// Hero section. Desktop: text on the left, an animated orbiting
/// tech-stack visual on the right — standing in for the portrait that
/// used to anchor that side, but built from real brand icons rather than
/// a photo. Mobile/tablet: everything centered, orbit visual scaled down
/// beneath the text (no room for a side-by-side split at those widths).
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onGetInTouch,
    this.onScrollDown,
  });

  final VoidCallback onGetInTouch;
  final VoidCallback? onScrollDown;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.of(context).size;

    Widget content;

    if (isDesktop) {
      final heroHeight = size.height.clamp(660.0, 820.0);
      content = SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: Responsive.pageHorizontalPadding(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 540),
                        child: _HeroContent(onGetInTouch: onGetInTouch, centered: false),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: _TechOrbit(size: (heroHeight * 0.58).clamp(320.0, 420.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (onScrollDown != null)
              Positioned(
                bottom: 18,
                left: 0,
                right: 0,
                child: Center(child: _ScrollIndicator(onTap: onScrollDown!)),
              ),
          ],
        ),
      );
    } else {
      final isMobile = Responsive.isMobile(context);
      content = Padding(
        padding: EdgeInsets.fromLTRB(20, isMobile ? 40 : 56, 20, isMobile ? 32 : 44),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: _HeroContent(onGetInTouch: onGetInTouch, centered: true),
            ),
            SizedBox(height: isMobile ? 28 : 36),
            _TechOrbit(size: isMobile ? 220 : 280),
            if (onScrollDown != null) ...[
              SizedBox(height: isMobile ? 20 : 28),
              _ScrollIndicator(onTap: onScrollDown!),
            ],
          ],
        ),
      );
    }

    return ClipRect(child: GradientBackground(child: content));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Text content: badge, name, role, tagline, CTAs, stats. `centered`
// switches between the desktop (left-aligned) and mobile/tablet
// (centered) presentation of the same content.
// ─────────────────────────────────────────────────────────────────────────────
class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.onGetInTouch, required this.centered});

  final VoidCallback onGetInTouch;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final crossAxis = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    final wrapAlign = centered ? WrapAlignment.center : WrapAlignment.start;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxis,
      children: [
        // ── Status badge ──────────────────────────────────────────────────
        _StatusBadge()
            .animate()
            .fadeIn(duration: 450.ms)
            .slideY(begin: 0.18, end: 0)
            .animate(onPlay: (c) => c.repeat(), delay: 1800.ms)
            .shimmer(duration: 1800.ms, color: Colors.white.withValues(alpha: 0.18)),
        const SizedBox(height: 18),

        // ── Name ──────────────────────────────────────────────────────────
        RichText(
          textAlign: textAlign,
          text: TextSpan(
            style: AppTextStyles.display(context),
            children: [
              const TextSpan(text: 'Talha '),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) => context.colors.primaryGradient.createShader(bounds),
                  child: Text(
                    'Saleem',
                    style: AppTextStyles.display(context).copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 600.ms).slideY(begin: 0.18, end: 0),
        const SizedBox(height: 14),

        // ── Role ──────────────────────────────────────────────────────────
        Text(
          AppConstants.role,
          textAlign: textAlign,
          style: AppTextStyles.heroSubtitle(context).copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(delay: 180.ms, duration: 600.ms),
        const SizedBox(height: 16),

        // ── Tagline ───────────────────────────────────────────────────────
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            AppConstants.tagline,
            textAlign: textAlign,
            style: AppTextStyles.body(context).copyWith(
              color: context.colors.textSecondary,
              height: 1.55,
            ),
          ),
        ).animate().fadeIn(delay: 240.ms, duration: 600.ms).slideY(begin: 0.12, end: 0),
        const SizedBox(height: 32),

        // ── CTA buttons ───────────────────────────────────────────────────
        Wrap(
          alignment: wrapAlign,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 10,
          children: [
            PrimaryButton(
              label: 'View my work',
              icon: Icons.arrow_outward_rounded,
              onPressed: () => context.go('/projects'),
            ),
            _MiniContactButton(onPressed: onGetInTouch),
          ],
        ).animate().fadeIn(delay: 320.ms, duration: 600.ms).slideY(begin: 0.12, end: 0),
        const SizedBox(height: 36),

        // ── Stats bar ─────────────────────────────────────────────────────
        _StatsBar(centered: centered).animate().fadeIn(delay: 420.ms, duration: 600.ms),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mini "Get In Touch" button — significantly smaller than primary CTA
// ─────────────────────────────────────────────────────────────────────────────
class _MiniContactButton extends StatefulWidget {
  const _MiniContactButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  State<_MiniContactButton> createState() => _MiniContactButtonState();
}

class _MiniContactButtonState extends State<_MiniContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? context.colors.primary.withValues(alpha: 0.1) : context.colors.glassFill,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: _hovered ? context.colors.primary.withValues(alpha: 0.6) : context.colors.glassBorder,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: context.colors.primary.withValues(alpha: 0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Text(
            'Get In Touch',
            style: AppTextStyles.button(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _hovered ? context.colors.textPrimary : context.colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status badge
// ─────────────────────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: context.colors.surfaceElevated.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.secondary.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: context.colors.success,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: context.colors.success, blurRadius: 6, spreadRadius: 1),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Hello, I'm",
            style: AppTextStyles.bodySmall(context).copyWith(
              color: context.colors.secondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stats bar — one centered, wrapping row of key highlights (same markup at
// every breakpoint; `Wrap` reflows from a single line down to several).
// ─────────────────────────────────────────────────────────────────────────────
class _StatsBar extends StatelessWidget {
  const _StatsBar({required this.centered});

  final bool centered;

  static const _stats = [
    (Icons.schedule_rounded, '4+ Years', 'Experience'),
    (Icons.rocket_launch_rounded, '30+ Apps', 'Shipped'),
    (Icons.devices_rounded, 'iOS & Android', 'Cross-Platform'),
    (Icons.storefront_rounded, 'Concept to', 'Store Launch'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: context.colors.surfaceElevated.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.glassBorder),
        boxShadow: context.shadows.card,
      ),
      child: Wrap(
        alignment: centered ? WrapAlignment.center : WrapAlignment.start,
        spacing: 22,
        runSpacing: 14,
        children: [for (final stat in _stats) _StatItem(stat: stat)],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.stat});
  final (IconData, String, String) stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: context.colors.secondary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(stat.$1, color: context.colors.secondary, size: 14),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              stat.$2,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            Text(
              stat.$3,
              style: AppTextStyles.bodySmall(context).copyWith(fontSize: 10.5, color: context.colors.textMuted),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated tech-stack orbit — stands in for the old portrait. A glowing
// central badge with two independently counter-rotating rings of real
// brand icons drawn from the actual stack — Flutter, Dart, Android, Apple
// (the two platforms every app ships to), Firebase, Git, Figma, Stripe —
// each rendered in its own authentic brand color, not decorative filler.
// ─────────────────────────────────────────────────────────────────────────────
class _TechOrbit extends StatefulWidget {
  const _TechOrbit({required this.size});
  final double size;

  @override
  State<_TechOrbit> createState() => _TechOrbitState();
}

class _TechOrbitState extends State<_TechOrbit> with TickerProviderStateMixin {
  late final AnimationController _ring1;
  late final AnimationController _ring2;
  late final AnimationController _pulse;

  static const _inner = [
    (SimpleIcons.dart, 'Dart', SimpleIconColors.dart),
    (SimpleIcons.android, 'Android', SimpleIconColors.android),
    (SimpleIcons.apple, 'iOS', SimpleIconColors.apple),
  ];
  static const _outer = [
    (SimpleIcons.firebase, 'Firebase', SimpleIconColors.firebase),
    (SimpleIcons.git, 'Git', SimpleIconColors.git),
    (SimpleIcons.figma, 'Figma', SimpleIconColors.figma),
    (SimpleIcons.stripe, 'Stripe', SimpleIconColors.stripe),
  ];

  @override
  void initState() {
    super.initState();
    _ring1 = AnimationController(vsync: this, duration: const Duration(seconds: 22))..repeat();
    _ring2 = AnimationController(vsync: this, duration: const Duration(seconds: 34))..repeat();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ring1.dispose();
    _ring2.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final innerRadius = size * 0.30;
    final outerRadius = size * 0.47;

    return RepaintBoundary(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _pulse,
              builder: (context, child) {
                final t = _pulse.value;
                return Container(
                  width: size * (0.62 + t * 0.06),
                  height: size * (0.62 + t * 0.06),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: context.colors.glow(opacity: 0.28 + t * 0.12),
                  ),
                );
              },
            ),
            _OrbitPath(diameter: outerRadius * 2),
            _OrbitPath(diameter: innerRadius * 2),
            _OrbitRing(
              animation: _ring2,
              radius: outerRadius,
              reverse: true,
              items: [for (final t in _outer) _OrbitChip(icon: t.$1, label: t.$2, color: t.$3)],
            ),
            _OrbitRing(
              animation: _ring1,
              radius: innerRadius,
              items: [for (final t in _inner) _OrbitChip(icon: t.$1, label: t.$2, color: t.$3)],
            ),
            _CentralBadge(size: size * 0.26, pulse: _pulse),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: 150.ms)
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 700.ms,
          delay: 150.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

class _OrbitPath extends StatelessWidget {
  const _OrbitPath({required this.diameter});
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.glassBorder, width: 1),
      ),
    );
  }
}

/// Lays out [items] evenly around a circle of [radius] and rotates the
/// whole ring via [animation] (0→1, repeating) — [reverse] flips the
/// spin direction so inner/outer rings visibly counter-rotate.
class _OrbitRing extends StatelessWidget {
  const _OrbitRing({
    required this.animation,
    required this.radius,
    required this.items,
    this.reverse = false,
  });

  final Animation<double> animation;
  final double radius;
  final List<Widget> items;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final baseAngle = (reverse ? -1 : 1) * animation.value * 2 * math.pi;
        return Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 0; i < items.length; i++)
              Transform.translate(
                offset: Offset.fromDirection(baseAngle + (2 * math.pi * i / items.length), radius),
                child: items[i],
              ),
          ],
        );
      },
    );
  }
}

/// A brand icon on its own small white badge — fixed-light rather than
/// theme-adaptive, so every authentic brand color (including very dark
/// ones like Flutter/Dart's blues or Apple's black) stays legible and
/// vivid in both dark and light site themes, the same way app-store-style
/// tech badges are usually shown.
class _OrbitChip extends StatelessWidget {
  const _OrbitChip({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFAFAFA),
          border: Border.all(color: color.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 14, spreadRadius: 1),
            const BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

class _CentralBadge extends StatelessWidget {
  const _CentralBadge({required this.size, required this.pulse});
  final double size;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        final glow = 0.25 + pulse.value * 0.25;
        return Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: context.colors.primaryGradient,
            boxShadow: [
              BoxShadow(color: context.colors.primary.withValues(alpha: glow), blurRadius: 36, spreadRadius: -4),
              BoxShadow(
                color: context.colors.secondary.withValues(alpha: glow * 0.7),
                blurRadius: 44,
                spreadRadius: -10,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFAFAFA)),
        alignment: Alignment.center,
        child: Icon(SimpleIcons.flutter, color: SimpleIconColors.flutter, size: size * 0.42),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated scroll indicator
// ─────────────────────────────────────────────────────────────────────────────
class _ScrollIndicator extends StatefulWidget {
  const _ScrollIndicator({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _bounce = Tween<double>(begin: 0, end: 6).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _bounce,
          builder: (_, child) => Transform.translate(offset: Offset(0, _bounce.value), child: child),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SCROLL',
                style: TextStyle(
                  color: context.colors.textMuted.withValues(alpha: 0.7),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 3),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.colors.secondary.withValues(alpha: 0.7),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 500.ms);
  }
}
