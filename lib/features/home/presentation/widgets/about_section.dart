import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'About Me',
            title: 'Engineering that ships, not just demos',
          ),
          const SizedBox(height: 28),
          ScrollReveal(
            delay: const Duration(milliseconds: 100),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(AppConstants.bio, style: AppTextStyles.body),
            ),
          ),
        ],
      ),
    );
  }
}
