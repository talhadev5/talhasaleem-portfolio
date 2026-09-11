import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/timeline_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Experience',
            title: 'Where I\'ve built and taught',
          ),
          const SizedBox(height: 36),
          for (int i = 0; i < experienceTimeline.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == experienceTimeline.length - 1 ? 0 : 20),
              child: ScrollReveal(
                delay: Duration(milliseconds: 100 * i),
                child: TimelineItem(
                  entry: experienceTimeline[i],
                  isLast: i == experienceTimeline.length - 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
