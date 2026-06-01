import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/animations/counter_animation.dart';
import '../../../../widgets/common/gradient_button.dart';
import '../../../../widgets/common/section_badge.dart';

class BenefitsSection extends StatelessWidget {
  const BenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: isMobile
              ? Column(children: [_BenefitsContent(), const SizedBox(height: 48), _StatsGrid()])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _BenefitsContent()),
                    const SizedBox(width: 80),
                    Expanded(flex: 4, child: _StatsGrid()),
                  ],
                ),
        ),
      ),
    );
  }
}

class _BenefitsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionBadge(label: 'Benefits'),
        const SizedBox(height: 16),
        Builder(builder: (context) {
          final isMobile = ResponsiveUtils.isMobile(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.benefitsTitle, style: isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(AppStrings.benefitsSubtitle, style: isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge).animate().fadeIn(duration: 600.ms, delay: 100.ms),
            ],
          );
        }),
        const SizedBox(height: 32),
        ...AppStrings.benefits.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.success.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check_rounded, color: AppColors.success, size: 16),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        e.value['text']!,
                        style: AppTextStyles.body.copyWith(color: AppColors.darkText),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 200 + e.key * 80)),
              ),
            ),
        const SizedBox(height: 32),
        GradientButton(label: 'Explore All Features', onPressed: () {})
            .animate()
            .fadeIn(duration: 600.ms, delay: 700.ms),
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = AppStrings.stats;
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: stats.asMap().entries.map((e) {
        final stat = e.value;
        return _StatCard(
          value: double.parse(stat['value']!),
          suffix: stat['suffix']!,
          label: stat['label']!,
          delay: Duration(milliseconds: e.key * 150),
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final double value;
  final String suffix;
  final String label;
  final Duration delay;

  const _StatCard({required this.value, required this.suffix, required this.label, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterAnimation(
            target: value,
            suffix: suffix,
            style: AppTextStyles.statValue.copyWith(fontSize: 36, color: AppColors.primary),
          ),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: delay).scale(begin: const Offset(0.9, 0.9), duration: 600.ms, delay: delay);
  }
}
