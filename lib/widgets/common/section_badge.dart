import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SectionBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const SectionBadge({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: c.withAlpha(20),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: c.withAlpha(40)),
      ),
      child: Text(label.toUpperCase(), style: AppTextStyles.sectionBadge.copyWith(color: c)),
    );
  }
}
