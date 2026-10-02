import '../theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';
import 'scroll_reveal.dart';

/// Small orange eyebrow label + big section title, used to open every
/// major section (About, Projects, Experience, Skills, Contact).
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.alignCenter = false,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool alignCenter;

  @override
  Widget build(BuildContext context) {
    final crossAxis = alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = alignCenter ? TextAlign.center : TextAlign.start;
    return ScrollReveal(
      child: Column(
        crossAxisAlignment: crossAxis,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 22,
                height: 2.5,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(eyebrow.toUpperCase(), style: AppTextStyles.sectionEyebrow(context), textAlign: textAlign),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.sectionTitle(context), textAlign: textAlign),
          if (subtitle != null) ...[
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(subtitle!, style: AppTextStyles.sectionSubtitle(context), textAlign: textAlign),
            ),
          ],
        ],
      ),
    );
  }
}
