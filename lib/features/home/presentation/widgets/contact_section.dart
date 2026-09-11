import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../contact/presentation/bloc/contact_form_bloc.dart';
import '../../../contact/presentation/widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return SectionContainer(
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Contact',
            title: 'Let\'s build something that ships',
            subtitle: 'Have a Flutter app to build, scale or rescue? I\'d love to hear about it.',
          ),
          const SizedBox(height: 32),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: isDesktop ? 4 : 0,
                child: ScrollReveal(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ContactLink(icon: Icons.mail_outline_rounded, label: AppConstants.email, url: 'mailto:${AppConstants.email}'),
                      const SizedBox(height: 14),
                      const _ContactLink(icon: Icons.phone_outlined, label: AppConstants.phone, url: 'tel:${AppConstants.phone}'),
                      const SizedBox(height: 14),
                      const _ContactLink(icon: Icons.business_center_outlined, label: 'LinkedIn Profile', url: AppConstants.linkedInUrl),
                      const SizedBox(height: 14),
                      const _ContactLink(icon: Icons.code_rounded, label: 'GitHub Profile', url: AppConstants.githubUrl),
                      const SizedBox(height: 24),
                      Text(
                        'Available for freelance engagements and full-time senior roles.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: isDesktop ? 56 : 0, height: isDesktop ? 0 : 32),
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: ScrollReveal(
                  delay: const Duration(milliseconds: 120),
                  child: BlocProvider(
                    create: (_) => ContactFormBloc(),
                    child: const ContactForm(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  const _ContactLink({required this.icon, required this.label, required this.url});
  final IconData icon;
  final String label;
  final String url;

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
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
          curve: Curves.easeOut,
          scale: _hovered ? 1.03 : 1.0,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _hovered ? AppColors.primary.withValues(alpha: 0.16) : AppColors.glassFill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, size: 18, color: _hovered ? AppColors.primary : AppColors.textSecondary),
              ),
              const SizedBox(width: 14),
              Text(
                widget.label,
                style: AppTextStyles.body.copyWith(color: _hovered ? AppColors.primary : AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
