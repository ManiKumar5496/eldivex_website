import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/section_badge.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  static IconData _icon(String key) => switch (key) {
        'verified_user' => Icons.verified_user_rounded,
        'lock' => Icons.lock_rounded,
        'admin_panel_settings' => Icons.admin_panel_settings_rounded,
        'history' => Icons.history_rounded,
        _ => Icons.security_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final cols = ResponsiveUtils.gridCrossAxisCount(context, desktop: 4, tablet: 2, mobile: 1);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.darkSectionBg, Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              SectionBadge(label: 'Security', color: AppColors.accent),
              const SizedBox(height: 16),
              Text(
                AppStrings.securityTitle,
                style: (isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(
                AppStrings.securitySubtitle,
                style: (isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge).copyWith(color: Colors.white60),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: const [
                  _ComplianceBadge(label: 'HIPAA Compliant'),
                  _ComplianceBadge(label: 'SOC 2 Type II'),
                  _ComplianceBadge(label: 'ISO 27001'),
                ],
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
              const SizedBox(height: 60),
              // Large shield icon
              Icon(Icons.shield_rounded, size: isMobile ? 80 : 100, color: AppColors.primary.withAlpha(60))
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 300.ms)
                  .scale(begin: const Offset(0.8, 0.8), duration: 800.ms, delay: 300.ms),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - (cols - 1) * 20) / cols;
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: AppStrings.securityFeatures.asMap().entries.map((e) {
                      final f = e.value;
                      return SizedBox(
                        width: itemWidth,
                        child: _SecurityCard(
                          title: f['title']!,
                          description: f['description']!,
                          icon: _icon(f['icon']!),
                          delay: Duration(milliseconds: e.key * 100),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComplianceBadge extends StatelessWidget {
  final String label;
  const _ComplianceBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withAlpha(30)),
        borderRadius: BorderRadius.circular(100),
        color: Colors.white.withAlpha(10),
      ),
      child: Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white70, fontWeight: FontWeight.w600)),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Duration delay;

  const _SecurityCard({required this.title, required this.description, required this.icon, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(8),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: Colors.white.withAlpha(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTextStyles.h4.copyWith(color: Colors.white, fontSize: 17)),
          const SizedBox(height: 8),
          Text(description, style: AppTextStyles.bodySmall.copyWith(color: Colors.white60)),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: delay)
        .slideY(begin: 0.15, duration: 600.ms, delay: delay);
  }
}
