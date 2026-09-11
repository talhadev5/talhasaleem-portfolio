import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.pageHorizontalPadding(context).horizontal / 2,
        vertical: 32,
      ),
      // Wrap (not a hard mobile/desktop Flex toggle) so any three-item
      // combination reflows cleanly instead of overflowing at in-between
      // (tablet) widths.
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: [
          Text('© ${DateTime.now().year} ${AppConstants.fullName}. All rights reserved.', style: AppTextStyles.bodySmall),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FooterIcon(icon: Icons.email_outlined, url: 'mailto:${AppConstants.email}'),
              const SizedBox(width: 14),
              _FooterIcon(icon: Icons.business_center_outlined, url: AppConstants.linkedInUrl),
              const SizedBox(width: 14),
              _FooterIcon(icon: Icons.code_rounded, url: AppConstants.githubUrl),
            ],
          ),
          const _FlutterBadge(),
        ],
      ),
    );
  }
}

class _FooterIcon extends StatefulWidget {
  const _FooterIcon({required this.icon, required this.url});
  final IconData icon;
  final String url;

  @override
  State<_FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<_FooterIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url), webOnlyWindowName: '_blank'),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 160),
          scale: _hovered ? 1.15 : 1.0,
          child: Icon(widget.icon, size: 18, color: _hovered ? AppColors.primary : AppColors.textMuted),
        ),
      ),
    );
  }
}

class _FlutterBadge extends StatelessWidget {
  const _FlutterBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.flutter_dash_rounded, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text('Built with Flutter', style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
