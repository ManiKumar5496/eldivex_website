import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/section_badge.dart';

class IndustriesSection extends StatelessWidget {
  const IndustriesSection({super.key});

  static IconData _icon(String name) => switch (name) {
        'Home Healthcare' => Icons.home_rounded,
        'Elder Care' => Icons.elderly_rounded,
        'Nursing Agencies' => Icons.local_hospital_rounded,
        'Rehabilitation' => Icons.accessibility_new_rounded,
        'Assisted Living' => Icons.apartment_rounded,
        _ => Icons.rocket_launch_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final cols = ResponsiveUtils.gridCrossAxisCount(context, desktop: 3, tablet: 2, mobile: 1);

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              const SectionBadge(label: 'Industries'),
              const SizedBox(height: 16),
              Text(AppStrings.industriesTitle, style: isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2, textAlign: TextAlign.center)
                  .animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(AppStrings.industriesSubtitle, style: isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge, textAlign: TextAlign.center)
                  .animate().fadeIn(duration: 600.ms, delay: 100.ms),
              SizedBox(height: isMobile ? 40 : 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - (cols - 1) * 20) / cols;
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: AppStrings.industries.asMap().entries.map((e) {
                      final industry = e.value;
                      return SizedBox(
                        width: itemWidth,
                        child: _IndustryCard(
                          name: industry['name']!,
                          description: industry['description']!,
                          icon: _icon(industry['name']!),
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

class _IndustryCard extends StatefulWidget {
  final String name;
  final String description;
  final IconData icon;
  final Duration delay;

  const _IndustryCard({required this.name, required this.description, required this.icon, required this.delay});

  @override
  State<_IndustryCard> createState() => _IndustryCardState();
}

class _IndustryCardState extends State<_IndustryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(color: _hovered ? AppColors.primary : AppColors.border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: _hovered ? AppColors.primary.withAlpha(40) : Colors.black.withAlpha(8),
              blurRadius: _hovered ? 24 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _hovered ? Colors.white.withAlpha(30) : AppColors.primary.withAlpha(15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(widget.icon, color: _hovered ? Colors.white : AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: AppTextStyles.h4.copyWith(fontSize: 16, color: _hovered ? Colors.white : AppColors.darkText)),
                  const SizedBox(height: 4),
                  Text(widget.description, style: AppTextStyles.bodySmall.copyWith(color: _hovered ? Colors.white70 : AppColors.secondaryText)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: _hovered ? Colors.white70 : AppColors.border),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 600.ms, delay: widget.delay)
          .slideY(begin: 0.15, duration: 600.ms, delay: widget.delay),
    );
  }
}
