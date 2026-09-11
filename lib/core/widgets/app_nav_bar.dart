import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive.dart';
import 'app_buttons.dart';

/// Sticky glass navigation bar shared by every route. Collapses to a
/// hamburger menu on mobile.
class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: preferredSize.height,
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.85),
            border: const Border(bottom: BorderSide(color: AppColors.divider)),
          ),
          padding: Responsive.pageHorizontalPadding(context),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.go('/'),
                child: Text(
                  '${AppConstants.fullName}.',
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 20),
                ),
              ),
              const Spacer(),
              if (isDesktop) ..._NavLinks.desktop(context) else _NavLinks.mobile(context),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLinks {
  static List<Widget> desktop(BuildContext context) {
    return [
      _NavLink(label: 'About', onTap: () => _goToSection(context, 'about')),
      _NavLink(label: 'Projects', onTap: () => _goToSection(context, 'projects')),
      _NavLink(label: 'Experience', onTap: () => _goToSection(context, 'experience')),
      _NavLink(label: 'Skills', onTap: () => _goToSection(context, 'skills')),
      const SizedBox(width: 14),
      PrimaryButton(
        label: 'Get In Touch',
        isCompact: true,
        onPressed: () => _goToSection(context, 'contact'),
      ),
    ];
  }

  static Widget mobile(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
      onPressed: () => showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.surface,
        builder: (sheetContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SheetLink(label: 'About', onTap: () {
                  Navigator.pop(sheetContext);
                  _goToSection(context, 'about');
                }),
                _SheetLink(label: 'Projects', onTap: () {
                  Navigator.pop(sheetContext);
                  _goToSection(context, 'projects');
                }),
                _SheetLink(label: 'Experience', onTap: () {
                  Navigator.pop(sheetContext);
                  _goToSection(context, 'experience');
                }),
                _SheetLink(label: 'Skills', onTap: () {
                  Navigator.pop(sheetContext);
                  _goToSection(context, 'skills');
                }),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Get In Touch',
                  isCompact: true,
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _goToSection(context, 'contact');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
  const _NavLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
                style: AppTextStyles.navLink.copyWith(color: _hovered ? AppColors.primary : AppColors.textSecondary),
                child: Text(widget.label),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                height: 2,
                width: _hovered ? 16 : 0,
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2)),
              ),
            ],
          ),
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
      title: Text(label, style: AppTextStyles.navLink.copyWith(fontSize: 16, color: AppColors.textPrimary)),
      onTap: onTap,
    );
  }
}

/// Lightweight registry that lets the nav bar trigger scrolling to a
/// named section on the Home page without a global state manager.
class SectionScrollRegistry {
  SectionScrollRegistry._();

  static final Map<String, GlobalKey> _keys = {};

  static void register(String anchor, GlobalKey key) => _keys[anchor] = key;

  static void scrollTo(String anchor) {
    final key = _keys[anchor];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 600), curve: Curves.easeInOutCubic);
    }
  }
}
