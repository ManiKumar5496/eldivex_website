import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';

enum AvatarSize { sm, md, lg, xl }

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final AvatarSize size;
  final Color? backgroundColor;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = AvatarSize.md,
    this.backgroundColor,
  });

  double get _diameter => switch (size) {
        AvatarSize.sm => 32,
        AvatarSize.md => 48,
        AvatarSize.lg => 64,
        AvatarSize.xl => 96,
      };

  double get _fontSize => switch (size) {
        AvatarSize.sm => 12,
        AvatarSize.md => 16,
        AvatarSize.lg => 22,
        AvatarSize.xl => 32,
      };

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _diameter,
      height: _diameter,
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: _diameter,
                height: _diameter,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => _initialsWidget,
                placeholder: (_, __) => _initialsWidget,
              )
            : _initialsWidget,
      ),
    );
  }

  Widget get _initialsWidget {
    return Container(
      width: _diameter,
      height: _diameter,
      color: backgroundColor ?? AppColors.primary.withAlpha(30),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.w600,
          color: backgroundColor != null ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}
