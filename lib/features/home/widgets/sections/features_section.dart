import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/section_badge.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _iconMap = {
    'people': Icons.people_alt_rounded,
    'folder_shared': Icons.folder_shared_rounded,
    'calendar_today': Icons.calendar_today_rounded,
    'assignment': Icons.assignment_rounded,
    'schedule': Icons.schedule_rounded,
    'payments': Icons.payments_rounded,
    'dashboard': Icons.dashboard_rounded,
    'notifications': Icons.notifications_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final cols = ResponsiveUtils.gridCrossAxisCount(context, desktop: 4, tablet: 2, mobile: 1);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              const SectionBadge(label: 'Features'),
              const SizedBox(height: 16),
              Text(
                AppStrings.featuresTitle,
                style: isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(
                AppStrings.featuresSubtitle,
                style: isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
              SizedBox(height: isMobile ? 40 : 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: AppStrings.features.asMap().entries.map((entry) {
                      final i = entry.key;
                      final feature = entry.value;
                      final itemWidth = (constraints.maxWidth - (cols - 1) * 20) / cols;
                      return SizedBox(
                        width: itemWidth,
                        child: _FeatureCard(
                          title: feature['title']!,
                          description: feature['description']!,
                          icon: _iconMap[feature['icon']] ?? Icons.star_rounded,
                          delay: Duration(milliseconds: i * 80),
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

class _FeatureCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Duration delay;

  const _FeatureCard({required this.title, required this.description, required this.icon, required this.delay});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(
            color: _hovered ? AppColors.primary.withAlpha(80) : AppColors.border,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? AppColors.primary.withAlpha(20) : Colors.black.withAlpha(5),
              blurRadius: _hovered ? 24 : 8,
              offset: Offset(0, _hovered ? 8 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: _hovered ? AppColors.primaryGradient : AppColors.cardGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                widget.icon,
                color: _hovered ? Colors.white : AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.title, style: AppTextStyles.h4.copyWith(fontSize: 17)),
            const SizedBox(height: 8),
            Text(widget.description, style: AppTextStyles.bodySmall),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 600.ms, delay: widget.delay)
          .slideY(begin: 0.2, duration: 600.ms, delay: widget.delay, curve: Curves.easeOutCubic),
    );
  }
}
