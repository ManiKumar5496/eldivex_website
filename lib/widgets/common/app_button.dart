import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum _AppButtonVariant { primary, secondary, outlined, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;
  final double? width;
  final double height;
  final _AppButtonVariant _variant;

  const AppButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
  }) : _variant = _AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
  }) : _variant = _AppButtonVariant.secondary;

  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
  }) : _variant = _AppButtonVariant.outlined;

  const AppButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
  }) : _variant = _AppButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();
    return SizedBox(
      width: width,
      height: height,
      child: switch (_variant) {
        _AppButtonVariant.primary => ElevatedButton(onPressed: isLoading ? null : onPressed, child: child),
        _AppButtonVariant.secondary => ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
            child: child,
          ),
        _AppButtonVariant.outlined => OutlinedButton(onPressed: isLoading ? null : onPressed, child: child),
        _AppButtonVariant.text => TextButton(onPressed: isLoading ? null : onPressed, child: child),
      },
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon!, const SizedBox(width: 8), Text(label, style: AppTextStyles.buttonText)],
      );
    }
    return Text(label, style: AppTextStyles.buttonText);
  }
}
