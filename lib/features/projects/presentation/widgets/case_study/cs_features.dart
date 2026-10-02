import '../../../../../core/theme/app_theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../../../core/widgets/scroll_reveal.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../domain/entities/project.dart';

/// Keyword → icon mapping so each real feature sentence gets a fitting
/// glyph instead of a repeated generic bullet. Falls back to a plain
/// check mark when nothing matches — never invents what the feature is.
IconData _iconFor(String feature) {
  final f = feature.toLowerCase();
  if (f.contains('map') || f.contains('track') || f.contains('location')) return Icons.map_rounded;
  if (f.contains('payment') || f.contains('stripe') || f.contains('paypal') || f.contains('billing') || f.contains('purchase')) {
    return Icons.payments_rounded;
  }
  if (f.contains('wallet') || f.contains('balance') || f.contains('fund') || f.contains('transaction')) return Icons.account_balance_wallet_rounded;
  if (f.contains('chat') || f.contains('messag') || f.contains('call')) return Icons.chat_bubble_rounded;
  if (f.contains('notif') || f.contains('remind')) return Icons.notifications_active_rounded;
  if (f.contains('admin') || f.contains('role') || f.contains('panel')) return Icons.admin_panel_settings_rounded;
  if (f.contains('report') || f.contains('history') || f.contains('record')) return Icons.insert_chart_rounded;
  if (f.contains('otp') || f.contains('secur') || f.contains('verif') || f.contains('privacy')) return Icons.verified_user_rounded;
  if (f.contains('subscription') || f.contains('tier')) return Icons.workspace_premium_rounded;
  if (f.contains('search') || f.contains('catalog') || f.contains('discover')) return Icons.search_rounded;
  if (f.contains('schedul') || f.contains('calendar') || f.contains('booking')) return Icons.event_available_rounded;
  if (f.contains('ai') || f.contains('ml') || f.contains('model') || f.contains('detect')) return Icons.auto_awesome_rounded;
  if (f.contains('cart') || f.contains('checkout') || f.contains('order')) return Icons.shopping_cart_rounded;
  if (f.contains('profile')) return Icons.badge_rounded;
  return Icons.check_circle_rounded;
}

/// Key features, each with its own icon and full real sentence —
/// presented as a two-column card grid rather than a bare bullet list,
/// but without inventing elaboration beyond the real feature text.
class CsFeatures extends StatelessWidget {
  const CsFeatures({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.features.isEmpty) return const SizedBox.shrink();
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 2);

    return SectionContainer(
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Key Features', title: 'What it delivers'),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 16.0;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (int i = 0; i < project.features.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: ScrollReveal(
                        delay: Duration(milliseconds: 50 * i),
                        offset: 12,
                        child: _FeatureCard(text: project.features[i]),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_iconFor(text), color: context.colors.primary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(text, style: AppTextStyles.body(context).copyWith(fontSize: 14.5)),
          ),
        ],
      ),
    );
  }
}
