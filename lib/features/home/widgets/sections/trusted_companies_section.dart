import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';

class TrustedCompaniesSection extends StatelessWidget {
  const TrustedCompaniesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 56),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: AppColors.border)),
        color: AppColors.background,
      ),
      child: Column(
        children: [
          Text(
            AppStrings.trustedTitle,
            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.5),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 32),
          _MarqueeRow(),
        ],
      ),
    );
  }
}

class _MarqueeRow extends StatefulWidget {
  @override
  State<_MarqueeRow> createState() => _MarqueeRowState();
}

class _MarqueeRowState extends State<_MarqueeRow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [...AppStrings.trustedCompanies, ...AppStrings.trustedCompanies];
    const itemWidth = 180.0;
    final totalWidth = itemWidth * items.length;

    return ClipRect(
      child: SizedBox(
        height: 56,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final offset = -_controller.value * totalWidth / 2;
            return Stack(
              children: [
                Positioned(
                  left: offset,
                  child: Row(
                    children: items
                        .map((name) => SizedBox(
                              width: itemWidth,
                              child: _CompanyLogo(name: name),
                            ))
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  final String name;
  const _CompanyLogo({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_hospital_outlined, size: 16, color: AppColors.secondaryText.withAlpha(150)),
          const SizedBox(width: 8),
          Text(
            name,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.secondaryText.withAlpha(150),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
