import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/timeline_item.dart';

/// IEEE certifications and leadership roles — same timeline visual
/// language as the Experience section, kept as its own section since
/// it's a distinct kind of credential.
class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Certifications & Leadership',
            title: 'IEEE community involvement',
          ),
          const SizedBox(height: 36),
          for (int i = 0; i < certificationsTimeline.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == certificationsTimeline.length - 1 ? 0 : 20),
              child: ScrollReveal(
                delay: Duration(milliseconds: 100 * i),
                child: TimelineItem(
                  entry: certificationsTimeline[i],
                  isLast: i == certificationsTimeline.length - 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
