import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/gradient_button.dart';
import '../../../../widgets/common/section_badge.dart';
import '../book_demo_modal.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFF0FDFA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            children: [
              const SectionBadge(label: 'Early Access'),
              const SizedBox(height: 20),
              Text(
                'Be Among Our First Partner Agencies',
                style: isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(
                'We\'re onboarding a select group of healthcare agencies as founding partners. Get priority support, influence the product roadmap, and lock in founding rates — forever.',
                style: isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
              const SizedBox(height: 48),
              _PartnerBenefitsList(isMobile: isMobile),
              const SizedBox(height: 48),
              GradientButton(
                label: 'Apply for Early Access',
                onPressed: () => showBookDemoModal(context),
                height: 54,
                icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
              ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
              const SizedBox(height: 16),
              Text(
                'No commitment required · Spots are limited',
                style: AppTextStyles.caption.copyWith(color: AppColors.secondaryText),
              ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _PartnerBenefitsList extends StatelessWidget {
  final bool isMobile;
  const _PartnerBenefitsList({required this.isMobile});

  static const _benefits = [
    (Icons.rocket_launch_rounded, 'Priority onboarding with a dedicated success manager'),
    (Icons.price_change_rounded, 'Founding partner pricing — your rate locked in forever'),
    (Icons.handshake_rounded, 'Direct access to our product team to shape features'),
    (Icons.verified_rounded, 'White-glove data migration and setup assistance'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _benefits.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 16 : 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(e.value.$1, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    e.value.$2,
                    style: AppTextStyles.body.copyWith(color: AppColors.darkText, fontWeight: FontWeight.w500),
                  ),
                ),
                const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 200 + e.key * 80))
           .slideX(begin: 0.1, duration: 600.ms, delay: Duration(milliseconds: 200 + e.key * 80)),
        );
      }).toList(),
    );
  }
}
