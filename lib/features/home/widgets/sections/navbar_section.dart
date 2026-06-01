import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../providers/ui_provider.dart';
import '../../../../widgets/common/gradient_button.dart';
import '../book_demo_modal.dart';

class NavbarSection extends ConsumerWidget {
  const NavbarSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrolled = ref.watch(navbarScrolledProvider);
    final isMobile = ResponsiveUtils.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: scrolled ? Colors.white.withAlpha(242) : Colors.transparent,
        boxShadow: scrolled
            ? [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 20, offset: const Offset(0, 4))]
            : [],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: scrolled
              ? ImageFilter.blur(sigmaX: 12, sigmaY: 12)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: SafeArea(
            child: SizedBox(
              height: 74,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.sectionPaddingH(context)),
                child: Row(
                  children: [
                    const _Logo(),
                    const Spacer(),
                    if (!isMobile) ...[
                      const _NavLinks(),
                      const SizedBox(width: 32),
                      const _BookDemoButton(),
                    ] else
                      const _MobileMenuButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return Image.asset(
      'assets/images/logo.png',
      height: isMobile ? 54 : 64,
      fit: BoxFit.contain,
    );
  }
}

class _NavLinks extends StatelessWidget {
  const _NavLinks();

  @override
  Widget build(BuildContext context) {
    final links = [
      AppStrings.navFeatures,
      AppStrings.navSolutions,
      AppStrings.navPricing,
      AppStrings.navContact,
    ];
    return Row(
      children: links
          .map((l) => InkWell(
                onTap: () {},
                mouseCursor: SystemMouseCursors.click,
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(l, style: AppTextStyles.navLink),
                ),
              ))
          .toList(),
    );
  }
}

class _BookDemoButton extends StatelessWidget {
  const _BookDemoButton();

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      label: AppStrings.navBookDemo,
      onPressed: () => showBookDemoModal(context),
      height: 40,
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.darkText),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (_) => _MobileMenu(ctx: context),
        );
      },
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final BuildContext ctx;
  const _MobileMenu({required this.ctx});

  @override
  Widget build(BuildContext context) {
    final links = [
      AppStrings.navFeatures,
      AppStrings.navSolutions,
      AppStrings.navPricing,
      AppStrings.navContact,
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...links.map((l) => ListTile(title: Text(l, style: AppTextStyles.h4))),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              label: AppStrings.navBookDemo,
              onPressed: () {
                Navigator.pop(ctx);
                showBookDemoModal(ctx);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
