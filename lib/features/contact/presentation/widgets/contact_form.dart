import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/glass_card.dart';
import '../bloc/contact_form_bloc.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    context.read<ContactFormBloc>().add(
          ContactFormSubmitted(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            message: _messageController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactFormBloc, ContactFormState>(
      listener: (context, state) {
        if (state.isSuccess) {
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      },
      builder: (context, state) {
        if (state.isSuccess) return const _SuccessCard();

        return GlassCard(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FormField(label: 'Name', controller: _nameController, validator: _requiredValidator),
                const SizedBox(height: 18),
                _FormField(label: 'Email', controller: _emailController, validator: _emailValidator),
                const SizedBox(height: 18),
                _FormField(label: 'Message', controller: _messageController, maxLines: 5, validator: _requiredValidator),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  child: state.isFailure
                      ? Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: _InlineMessage(
                            icon: Icons.error_outline_rounded,
                            color: Colors.redAccent,
                            text: 'Something went wrong, please try again.',
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: state.isSubmitting
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.primary),
                            ),
                          )
                        : PrimaryButton(
                            label: state.isFailure ? 'Try Again' : 'Send Message',
                            icon: Icons.send_rounded,
                            onPressed: _submit,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _requiredValidator(String? value) => (value == null || value.trim().isEmpty) ? 'Required' : null;

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    final valid = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\-\.]+$').hasMatch(value.trim());
    return valid ? null : 'Enter a valid email';
  }
}

class _FormField extends StatelessWidget {
  const _FormField({required this.label, required this.controller, required this.validator, this.maxLines = 1});

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.glassBorder)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.glassBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
          ),
        ),
      ],
    );
  }
}

class _InlineMessage extends StatelessWidget {
  const _InlineMessage({required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.bodySmall.copyWith(color: color))),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: -0.2, end: 0, duration: 250.ms);
  }
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 28),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.14), shape: BoxShape.circle),
            child: const Icon(Icons.check_rounded, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: 18),
          Text('Message sent', style: AppTextStyles.cardTitle),
          const SizedBox(height: 8),
          Text(
            'Thanks for reaching out — I\'ll get back to you shortly.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms).scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1), curve: Curves.easeOutBack);
  }
}
