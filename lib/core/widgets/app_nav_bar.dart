import 'dart:ui';
import '../theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive.dart';
import 'app_buttons.dart';
import 'page_scroll.dart';
import 'theme_toggle_button.dart';

/// Sticky glass navigation bar shared by every route. Transparent at the
/// top of the page, gaining a blurred background as soon as the page
/// scrolls (tracked via [PageScroll], not a local scroll listener, since
/// the navbar sits outside the scrollable as `Scaffold.appBar`). Collapses
/// to a hamburger menu on mobile.
class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return ValueListenableBuilder<double>(
      valueListenable: PageScroll.offset,
      builder: (context, offset, child) {
        final t = (offset / 24).clamp(0.0, 1.0);
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14 * t, sigmaY: 14 * t),
            child: Container(
              height: preferredSize.height,
              decoration: BoxDecoration(
                color: context.colors.background.withValues(alpha: 0.85 * t),
                border: Border(
                  bottom: BorderSide(
                    color: context.colors.divider.withValues(alpha: t),
                  ),
                ),
              ),
              padding: Responsive.pageHorizontalPadding(context),
              child: child,
            ),
          ),
        );
      },
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: Text(
              '${AppConstants.fullName}.',
              style: AppTextStyles.cardTitle(context).copyWith(fontSize: 20),
            ),
          ),
          const Spacer(),
          if (isDesktop)
            ..._NavLinks.desktop(context)
          else
            ..._NavLinks.mobile(context),
        ],
      ),
    );
  }
}

class _NavLinks {
  static List<Widget> desktop(BuildContext context) {
    return [
      _NavLink(
        label: 'About',
        anchor: 'about',
        onTap: () => _goToSection(context, 'about'),
      ),
      _NavLink(
        label: 'Projects',
        anchor: 'projects',
        onTap: () => _goToSection(context, 'projects'),
      ),
      _NavLink(
        label: 'Experience',
        anchor: 'experience',
        onTap: () => _goToSection(context, 'experience'),
      ),
      _NavLink(
        label: 'Skills',
        anchor: 'skills',
        onTap: () => _goToSection(context, 'skills'),
      ),
      const SizedBox(width: 12),
      _CompactNavCta(
        label: 'Get In Touch',
        onPressed: () => _goToSection(context, 'contact'),
      ),
      const SizedBox(width: 12),
      const ThemeToggleButton(),
    ];
  }

  static List<Widget> mobile(BuildContext context) {
    return [
      const ThemeToggleButton(),
      const SizedBox(width: 6),
      IconButton(
        icon: Icon(Icons.menu_rounded, color: context.colors.textPrimary),
        onPressed: () => showModalBottomSheet(
          context: context,
          backgroundColor: context.colors.surface,
          builder: (sheetContext) => _MobileMenuSheet(
            onLinkTap: (anchor) {
              Navigator.pop(sheetContext);
              _goToSection(context, anchor);
            },
          ),
        ),
      ),
    ];
  }

  static void _goToSection(BuildContext context, String anchor) {
    if (GoRouterState.of(context).uri.path != '/') {
      context.go('/#$anchor');
    } else {
      SectionScrollRegistry.scrollTo(anchor);
    }
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.anchor,
    required this.onTap,
  });
  final String label;
  final String anchor;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: SectionScrollRegistry.activeSection,
      builder: (context, active, _) {
        final isActive = active == widget.anchor;
        final highlighted = _hovered || isActive;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 180),
                    style: AppTextStyles.navLink(context).copyWith(
                      color: highlighted
                          ? context.colors.primary
                          : context.colors.textSecondary,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                    child: Text(widget.label),
                  ),
                  const SizedBox(height: 3),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    height: 2,
                    width: highlighted ? 16 : 0,
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Mobile nav drawer content — each item fades + slides in with a small
/// staggered delay as the sheet opens, instead of appearing all at once.
class _MobileMenuSheet extends StatelessWidget {
  const _MobileMenuSheet({required this.onLinkTap});

  final ValueChanged<String> onLinkTap;

  static const _links = ['About', 'Projects', 'Experience', 'Skills'];
  static const _anchors = ['about', 'projects', 'experience', 'skills'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < _links.length; i++)
              _SheetLink(label: _links[i], onTap: () => onLinkTap(_anchors[i]))
                  .animate(delay: Duration(milliseconds: 40 * i))
                  .fadeIn(duration: 220.ms)
                  .slideX(begin: 0.06, end: 0),
            const SizedBox(height: 12),
            PrimaryButton(
                  label: 'Get In Touch',
                  isCompact: true,
                  onPressed: () => onLinkTap('contact'),
                )
                .animate(delay: Duration(milliseconds: 40 * _links.length))
                .fadeIn(duration: 220.ms)
                .slideX(begin: 0.06, end: 0),
          ],
        ),
      ),
    );
  }
}

class _SheetLink extends StatelessWidget {
  const _SheetLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: AppTextStyles.navLink(
          context,
        ).copyWith(fontSize: 16, color: context.colors.textPrimary),
      ),
      onTap: onTap,
    );
  }
}

/// Very small "Get In Touch" CTA used in the desktop navbar — more compact
/// than PrimaryButton, styled as a subtle outlined pill.
class _CompactNavCta extends StatefulWidget {
  const _CompactNavCta({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  State<_CompactNavCta> createState() => _CompactNavCtaState();
}

class _CompactNavCtaState extends State<_CompactNavCta> {
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
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
          decoration: BoxDecoration(
            gradient: _hovered ? context.colors.primaryGradient : null,
            color: _hovered ? null : context.colors.glassFill,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: _hovered ? Colors.transparent : context.colors.glassBorder,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: context.colors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.navLink(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _hovered
                  ? context.colors.onAccent
                  : context.colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Lightweight registry that lets the nav bar trigger scrolling to a
/// named section on the Home page without a global state manager, and
/// tracks which section is currently in view for the active-link
/// indicator ("scrollspy").
class SectionScrollRegistry {
  SectionScrollRegistry._();

  static final Map<String, GlobalKey> _keys = {};
  static final ValueNotifier<String?> activeSection = ValueNotifier(null);

  /// How far from the top of the viewport (below the fixed navbar) a
  /// section's top edge must cross before it's considered "active".
  static const double _referenceLine = 120;

  static void register(String anchor, GlobalKey key) => _keys[anchor] = key;

  static void unregister(String anchor, GlobalKey key) {
    if (identical(_keys[anchor], key)) _keys.remove(anchor);
  }

  static void scrollTo(String anchor) {
    final key = _keys[anchor];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  /// Called on every scroll tick of the current page (see
  /// [AppPageScaffold]) to recompute which registered section is active:
  /// the lowest section whose top has scrolled above [_referenceLine].
  static void updateActiveSection(double scrollOffset) {
    String? best;
    double bestTop = double.negativeInfinity;
    for (final entry in _keys.entries) {
      final box = entry.value.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= _referenceLine && top > bestTop) {
        bestTop = top;
        best = entry.key;
      }
    }
    if (activeSection.value != best) activeSection.value = best;
  }
}
