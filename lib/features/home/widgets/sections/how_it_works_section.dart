import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/section_badge.dart';

IconData _stepIcon(String? key) {
  return switch (key) {
    'person_add' => Icons.person_add_rounded,
    'personal_injury' => Icons.personal_injury_rounded,
    'assignment_add' => Icons.note_add_rounded,
    'event_available' => Icons.event_available_rounded,
    'analytics' => Icons.analytics_rounded,
    _ => Icons.star_rounded,
  };
}

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              const SectionBadge(label: 'How It Works'),
              const SizedBox(height: 16),
              Text(AppStrings.howItWorksTitle, style: isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2, textAlign: TextAlign.center)
                  .animate()
                  .fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(AppStrings.howItWorksSubtitle, style: isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge, textAlign: TextAlign.center)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 100.ms),
              SizedBox(height: isMobile ? 40 : 60),
              isMobile ? const _VerticalTimeline() : const _HorizontalTimeline(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HorizontalTimeline extends StatelessWidget {
  const _HorizontalTimeline();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 60,
          right: 60,
          top: 40,
          child: Container(
            height: 2,
            decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AppStrings.steps.asMap().entries.map((entry) {
            final step = entry.value;
            return Expanded(
              child: _StepCard(
                number: step['number']!,
                title: step['title']!,
                description: step['description']!,
                icon: _stepIcon(step['icon']),
                delay: Duration(milliseconds: entry.key * 150),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _VerticalTimeline extends StatelessWidget {
  const _VerticalTimeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AppStrings.steps.asMap().entries.map((entry) {
        final step = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _StepRow(
            number: step['number']!,
            title: step['title']!,
            description: step['description']!,
            icon: _stepIcon(step['icon']),
            delay: Duration(milliseconds: entry.key * 100),
          ),
        );
      }).toList(),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Duration delay;

  const _StepCard({required this.number, required this.title, required this.description, required this.icon, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.primary.withAlpha(50), blurRadius: 20, offset: const Offset(0, 8))],
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 20),
        Text(number, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700, letterSpacing: 1)),
        const SizedBox(height: 6),
        Text(title, style: AppTextStyles.h4.copyWith(fontSize: 16), textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(description, style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: delay)
        .slideY(begin: 0.2, duration: 600.ms, delay: delay, curve: Curves.easeOutCubic);
  }
}

class _StepRow extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Duration delay;

  const _StepRow({required this.number, required this.title, required this.description, required this.icon, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(number, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
              Text(title, style: AppTextStyles.h4.copyWith(fontSize: 16)),
              const SizedBox(height: 4),
              Text(description, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: delay).slideX(begin: -0.1, duration: 600.ms, delay: delay);
  }
}
