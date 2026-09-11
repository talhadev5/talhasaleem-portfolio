import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';

class _Tool {
  const _Tool(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// VS Code has no brand glyph in `simple_icons` (Microsoft trademark
/// restriction upstream), so it falls back to a generic code icon.
const List<_Tool> _tools = [
  _Tool('Git', SimpleIcons.git),
  _Tool('GitHub', SimpleIcons.github),
  _Tool('VS Code', Icons.code_rounded),
  _Tool('Android Studio', SimpleIcons.androidstudio),
  _Tool('Xcode', SimpleIcons.xcode),
  _Tool('Firebase Console', SimpleIcons.firebase),
  _Tool('Postman', SimpleIcons.postman),
  _Tool('Figma', SimpleIcons.figma),
  _Tool('App Store Connect', SimpleIcons.appstore),
  _Tool('Google Play Console', SimpleIcons.googleplay),
];

/// Editors, platforms and dev tools — separate from Core Skills, which
/// is competencies rather than software.
class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Tools & Technologies',
            title: 'What\'s on my daily toolbelt',
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              for (int i = 0; i < _tools.length; i++)
                ScrollReveal(
                  delay: Duration(milliseconds: 40 * i),
                  offset: 16,
                  child: _ToolTile(tool: _tools[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolTile extends StatefulWidget {
  const _ToolTile({required this.tool});
  final _Tool tool;

  @override
  State<_ToolTile> createState() => _ToolTileState();
}

class _ToolTileState extends State<_ToolTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final width = Responsive.value<double>(context, mobile: 148, tablet: 156, desktop: 164);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        scale: _hovered ? 1.05 : 1.0,
        child: SizedBox(
          width: width,
          height: 92,
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            borderColor: _hovered ? AppColors.primary.withValues(alpha: 0.5) : AppColors.glassBorder,
            fillColor: _hovered ? AppColors.primary.withValues(alpha: 0.08) : AppColors.glassFill,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.tool.icon, size: 22, color: _hovered ? AppColors.primary : AppColors.textSecondary),
                const SizedBox(height: 10),
                Text(
                  widget.tool.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: _hovered ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
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
