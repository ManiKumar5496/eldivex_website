import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/utils/site_links.dart';
import '../../../../providers/ui_provider.dart';
import '../../../../services/analytics_service.dart';
import '../../../../widgets/common/gradient_button.dart';
import '../book_demo_modal.dart';
import '../../home_sections.dart';

/// Navbar links and the home-page section each one scrolls to.
final List<(String, GlobalKey)> _navTargets = [
  (AppStrings.navFeatures, HomeSections.features),
  (AppStrings.navSolutions, HomeSections.solutions),
  (AppStrings.navPricing, HomeSections.pricing),
  (AppStrings.navContact, HomeSections.contact),
];

void _goToSection(String label, GlobalKey key) {
  AnalyticsService.instance
      .logCtaClick('nav_${label.toLowerCase()}', source: 'navbar');
  HomeSections.scrollTo(key);
}

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
                      if (SiteLinks.hasLogin) ...[
                        const _LoginButton(),
                        const SizedBox(width: 12),
                      ],
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
    return Row(
      children: _navTargets
          .map((t) => InkWell(
                onTap: () => _goToSection(t.$1, t.$2),
                mouseCursor: SystemMouseCursors.click,
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(t.$1, style: AppTextStyles.navLink),
                ),
              ))
          .toList(),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => SiteLinks.openLogin(source: 'navbar'),
      child: Text(AppStrings.navLogin, style: AppTextStyles.navLink),
    );
  }
}

class _BookDemoButton extends StatelessWidget {
  const _BookDemoButton();

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      label: AppStrings.navBookDemo,
      onPressed: () => showBookDemoModal(context, source: 'navbar'),
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._navTargets.map((t) => ListTile(
                title: Text(t.$1, style: AppTextStyles.h4),
                onTap: () {
                  Navigator.pop(context);
                  _goToSection(t.$1, t.$2);
                },
              )),
          if (SiteLinks.hasLogin)
            ListTile(
              title: Text(AppStrings.navLogin, style: AppTextStyles.h4),
              trailing: const Icon(Icons.open_in_new_rounded, size: 18),
              onTap: () {
                Navigator.pop(context);
                SiteLinks.openLogin(source: 'mobile_menu');
              },
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              label: AppStrings.navBookDemo,
              onPressed: () {
                Navigator.pop(context);
                showBookDemoModal(ctx, source: 'mobile_menu');
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
