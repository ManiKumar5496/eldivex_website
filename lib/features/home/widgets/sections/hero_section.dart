import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/gradient_button.dart';
import '../book_demo_modal.dart';
import 'hero_dashboard_mockup.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final ph = ResponsiveUtils.sectionPaddingH(context);

    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 600 : MediaQuery.of(context).size.height),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF0F7FF), Color(0xFFECFEFF), Color(0xFFF8FAFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: _BackgroundBlobs()),
          Padding(
            padding: EdgeInsets.fromLTRB(ph, isMobile ? 80 : 120, ph, 60),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: isMobile ? _MobileLayout() : isTablet ? _TabletLayout() : _DesktopLayout(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 5, child: _HeroContent()),
        const SizedBox(width: 60),
        Expanded(flex: 5, child: Align(alignment: Alignment.centerRight, child: const HeroDashboardMockup())),
      ],
    );
  }
}

class _TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _HeroContent(),
        const SizedBox(height: 40),
        const HeroDashboardMockup(showFloating: false),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _HeroContent(),
        const SizedBox(height: 32),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: const HeroDashboardMockup(showFloating: false),
        ),
      ],
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    final headingStyle = isMobile
        ? AppTextStyles.heroHeadingMobile
        : isTablet
            ? AppTextStyles.heroHeadingTablet
            : AppTextStyles.heroHeading;

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.primary.withAlpha(40)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  '🚀  New: AI-Powered Care Plan Generator',
                  style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            'Transform Your\nCaregiving Operations',
            style: headingStyle.copyWith(color: Colors.white),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.15),
        Text(
          'with One Powerful Platform',
          style: headingStyle,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).animate().fadeIn(duration: 800.ms, delay: 300.ms).slideY(begin: 0.15),
        const SizedBox(height: 24),
        Text(
          AppStrings.heroSubheading,
          style: isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
        const SizedBox(height: 32),
        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GradientButton(
                label: AppStrings.heroCtaPrimary,
                onPressed: () => showBookDemoModal(context, source: 'hero'),
                height: 52,
                icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => showBookDemoModal(context, source: 'hero_watch_demo'),
                icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
                label: const Text('Watch Demo'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms, delay: 500.ms)
        else
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GradientButton(
                label: AppStrings.heroCtaPrimary,
                onPressed: () => showBookDemoModal(context, source: 'hero'),
                height: 52,
                icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
              ),
              OutlinedButton.icon(
                onPressed: () => showBookDemoModal(context, source: 'hero_watch_demo'),
                icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
                label: const Text('Watch Demo'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms, delay: 500.ms),
        const SizedBox(height: 36),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            AppStrings.heroTrustBadge1,
            AppStrings.heroTrustBadge2,
            AppStrings.heroTrustBadge3,
          ]
              .map((badge) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16),
                      const SizedBox(width: 6),
                      Text(badge, style: AppTextStyles.bodySmall.copyWith(color: AppColors.darkText, fontWeight: FontWeight.w500)),
                    ],
                  ))
              .toList(),
        ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
      ],
    );
  }
}

class _BackgroundBlobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withAlpha(12),
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: -80,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withAlpha(12),
            ),
          ),
        ),
      ],
    );
  }
}
