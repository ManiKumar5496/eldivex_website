import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';

class AppCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool hoverable;
  final Color? backgroundColor;
  final double borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.width,
    this.height,
    this.hoverable = false,
    this.backgroundColor,
    this.borderRadius = AppConstants.cardBorderRadius,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.hoverable ? (_) => setState(() => _hovered = true) : null,
      onExit: widget.hoverable ? (_) => setState(() => _hovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.cardBg,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(_hovered ? 15 : 8),
              blurRadius: _hovered ? 24 : 8,
              offset: Offset(0, _hovered ? 8 : 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            onTap: widget.onTap,
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(24),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
