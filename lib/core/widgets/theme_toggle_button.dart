import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme_x.dart';
import '../theme/theme_cubit.dart';

/// Animated sun/moon morph toggle. Rotates + cross-fades between the two
/// glyphs over `context.durations.themeSwitch` (~400ms), collapsing to
/// near-instant under reduced motion.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeCubit>().state;
    final isDark = mode == ThemeMode.dark ||
        (mode == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    final duration = context.motion(context.durations.themeSwitch);

    return Tooltip(
      message: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: Semantics(
        button: true,
        label: isDark ? 'Switch to light mode' : 'Switch to dark mode',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.read<ThemeCubit>().toggle(),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: context.colors.glassFill,
                borderRadius: BorderRadius.circular(context.radii.md),
                border: Border.all(color: context.colors.glassBorder),
              ),
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: duration,
                transitionBuilder: (child, animation) => RotationTransition(
                  turns: Tween<double>(begin: 0.72, end: 1).animate(animation),
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  key: ValueKey(isDark),
                  size: 18,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
