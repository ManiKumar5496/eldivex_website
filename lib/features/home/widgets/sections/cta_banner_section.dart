import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/gradient_button.dart';
import '../book_demo_modal.dart';

class CtaBannerSection extends StatelessWidget {
  const CtaBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, Color(0xFF0891B2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Floating glow circles in background
          Positioned(top: -60, left: -40, child: _GlowCircle(size: 300, opacity: 0.12)),
          Positioned(bottom: -60, right: -40, child: _GlowCircle(size: 250, opacity: 0.10)),
          Center(
            child: Column(
              children: [
                Text(
                  AppStrings.ctaTitle,
                  style: (isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2).copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.1),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    AppStrings.ctaSubtitle,
                    style: AppTextStyles.bodyLarge.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 700.ms, delay: 100.ms),
                ),
                const SizedBox(height: 36),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    GradientButton(
                      label: AppStrings.ctaPrimary,
                      onPressed: () => showBookDemoModal(context),
                      height: 54,
                      width: 200,
                    ),
                    OutlinedButton(
                      onPressed: () => showBookDemoModal(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 1.5),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      ),
                      child: Text(AppStrings.ctaSecondary, style: AppTextStyles.buttonText.copyWith(color: Colors.white)),
                    ),
                  ],
                ).animate().fadeIn(duration: 700.ms, delay: 200.ms),
                const SizedBox(height: 24),
                Text(
                  '✓ No credit card required  ✓ 14-day free trial  ✓ Cancel anytime',
                  style: AppTextStyles.bodySmall.copyWith(color: Colors.white60),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 700.ms, delay: 300.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final double opacity;
  const _GlowCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.05, 1.05), duration: 3000.ms, curve: Curves.easeInOut);
  }
}
