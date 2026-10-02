import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// What the product does, for whom, and why it matters — the project's
/// own real `description`, given room and a proper heading rather than
/// being folded into a sidebar.
class CsOverview extends StatelessWidget {
  const CsOverview({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Overview', title: 'What it does'),
          const SizedBox(height: 24),
          ScrollReveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(project.description, style: AppTextStyles.body(context)),
            ),
          ),
        ],
      ),
    );
  }
}
