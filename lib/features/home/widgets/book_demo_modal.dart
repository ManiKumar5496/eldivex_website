import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../services/analytics_service.dart';
import '../../../widgets/common/app_text_field.dart';
import '../../../widgets/common/gradient_button.dart';

/// Shows the Book Demo modal dialog. [source] identifies the CTA that opened
/// it, for analytics.
void showBookDemoModal(BuildContext context, {String source = 'unknown'}) {
  AnalyticsService.instance.logCtaClick('book_demo', source: source);
  showDialog(
    context: context,
    barrierColor: Colors.black.withAlpha(100),
    builder: (_) => const _BookDemoDialog(),
  );
}

class _BookDemoDialog extends StatefulWidget {
  const _BookDemoDialog();

  @override
  State<_BookDemoDialog> createState() => _BookDemoDialogState();
}

class _BookDemoDialogState extends State<_BookDemoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String? _selectedTeamSize;
  bool _submitting = false;
  bool _submitted = false;

  static const _teamSizes = ['1–10', '11–50', '51–200', '201–500', '500+'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _companyCtrl.dispose();
    _phoneCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      await FirebaseFirestore.instance.collection('leads_website').add({
        'Name': _nameCtrl.text.trim(),
        'Email': _emailCtrl.text.trim(),
        'Phone_number': _phoneCtrl.text.trim(),
        'about_agency': _messageCtrl.text.trim(),
        'team_size': _selectedTeamSize ?? '',
        'company': _companyCtrl.text.trim(),
        'submitted_at': FieldValue.serverTimestamp(),
      });
      AnalyticsService.instance.logDemoRequested(teamSize: _selectedTeamSize);
      if (mounted) setState(() { _submitting = false; _submitted = true; });
    } catch (_) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(40), blurRadius: 60, offset: const Offset(0, 20)),
              ],
            ),
            child: _submitted ? _SuccessView() : _FormView(
              formKey: _formKey,
              nameCtrl: _nameCtrl,
              emailCtrl: _emailCtrl,
              companyCtrl: _companyCtrl,
              phoneCtrl: _phoneCtrl,
              messageCtrl: _messageCtrl,
              selectedTeamSize: _selectedTeamSize,
              teamSizes: _teamSizes,
              onTeamSizeChanged: (v) => setState(() => _selectedTeamSize = v),
              submitting: _submitting,
              onSubmit: _submit,
            ),
          ),
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl, emailCtrl, companyCtrl, phoneCtrl, messageCtrl;
  final String? selectedTeamSize;
  final List<String> teamSizes;
  final ValueChanged<String?> onTeamSizeChanged;
  final bool submitting;
  final VoidCallback onSubmit;

  const _FormView({
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.companyCtrl,
    required this.phoneCtrl,
    required this.messageCtrl,
    required this.selectedTeamSize,
    required this.teamSizes,
    required this.onTeamSizeChanged,
    required this.submitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(36),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Book Your Free Demo', style: AppTextStyles.h2.copyWith(fontSize: 26)),
            const SizedBox(height: 8),
            Text(
              'See how Eldivex can transform your caregiving operations. A product specialist will reach out within 24 hours.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(child: AppTextField(controller: nameCtrl, label: 'Full Name *', hint: 'Jane Smith', validator: AppValidators.validateName, prefixIcon: const Icon(Icons.person_outline, size: 18))),
                const SizedBox(width: 16),
                Expanded(child: AppTextField(controller: emailCtrl, label: 'Work Email *', hint: 'jane@company.com', keyboardType: TextInputType.emailAddress, validator: AppValidators.validateEmail, prefixIcon: const Icon(Icons.email_outlined, size: 18))),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: AppTextField(controller: companyCtrl, label: 'Company Name *', hint: 'Acme Healthcare', validator: AppValidators.validateRequired, prefixIcon: const Icon(Icons.business_outlined, size: 18))),
                const SizedBox(width: 16),
                Expanded(child: AppTextField(controller: phoneCtrl, label: 'Phone Number', hint: '+1 (555) 000-0000', keyboardType: TextInputType.phone, validator: AppValidators.validatePhone, prefixIcon: const Icon(Icons.phone_outlined, size: 18))),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedTeamSize,
              decoration: InputDecoration(
                labelText: 'Team Size',
                prefixIcon: const Icon(Icons.group_outlined, size: 18),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
              ),
              items: teamSizes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: onTeamSizeChanged,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: messageCtrl,
              label: 'Tell us about your agency',
              hint: 'How many caregivers do you manage? What are your biggest challenges?',
              maxLines: 3,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: GradientButton(
                label: 'Book My Free Demo',
                onPressed: onSubmit,
                isLoading: submitting,
                height: 52,
                icon: const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 18),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 14, color: AppColors.secondaryText),
                const SizedBox(width: 6),
                Text('No spam, no commitment. Unsubscribe anytime.', style: AppTextStyles.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.success.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 44),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 24),
          Text('Demo Booked!', style: AppTextStyles.h2.copyWith(fontSize: 28), textAlign: TextAlign.center)
              .animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 12),
          Text(
            'Thank you! An Eldivex specialist will reach out within 24 hours to schedule your personalized demo.',
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }
}
