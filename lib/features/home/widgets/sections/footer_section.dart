import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Material(
      color: AppColors.darkSectionBg,
      child: Container(
        padding: EdgeInsets.fromLTRB(ph, 64, ph, 32),
        child: Column(
          children: [
            isMobile ? _MobileFooterBody() : _DesktopFooterBody(),
            const SizedBox(height: 48),
            const Divider(color: Color(0xFF1E293B), thickness: 1),
            const SizedBox(height: 24),
            _BottomBar(),
          ],
        ),
      ),
    );
  }
}

class _DesktopFooterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _BrandColumn()),
        const SizedBox(width: 40),
        ...AppStrings.footerLinks.map(
          (section) => Expanded(
            flex: 2,
            child: _LinkColumn(
              heading: section['heading'] as String,
              links: List<String>.from(section['links'] as List),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileFooterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BrandColumn(),
        const SizedBox(height: 40),
        ...AppStrings.footerLinks.map(
          (section) => Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _LinkColumn(
              heading: section['heading'] as String,
              links: List<String>.from(section['links'] as List),
            ),
          ),
        ),
      ],
    );
  }
}

class _BrandColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Image.asset(
            'assets/images/logo.png',
            height: 48,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Modern healthcare caregiving platform helping agencies manage caregivers, patients, and operations efficiently.',
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white38),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SocialIcon(icon: FontAwesomeIcons.facebook, label: 'Facebook', url: 'https://facebook.com/eldivex'),
            const SizedBox(width: 12),
            _SocialIcon(icon: FontAwesomeIcons.instagram, label: 'Instagram', url: 'https://instagram.com/eldivex'),
            const SizedBox(width: 12),
            _SocialIcon(icon: FontAwesomeIcons.linkedin, label: 'LinkedIn', url: 'https://linkedin.com/company/eldivex'),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  const _SocialIcon({required this.icon, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
        mouseCursor: SystemMouseCursors.click,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(10),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withAlpha(15)),
          ),
          child: Center(child: FaIcon(icon, color: Colors.white54, size: 16)),
        ),
      ),
    );
  }
}

class _LinkColumn extends StatelessWidget {
  final String heading;
  final List<String> links;
  const _LinkColumn({required this.heading, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: AppTextStyles.label.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        ...links.map(
          (link) => InkWell(
            onTap: () {},
            mouseCursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(link, style: AppTextStyles.bodySmall.copyWith(color: Colors.white38)),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return isMobile
        ? Column(
            children: [
              Text('© 2024 Eldivex Inc. All rights reserved.', style: AppTextStyles.caption.copyWith(color: Colors.white38)),
              const SizedBox(height: 8),
              _LegalLinks(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('© 2024 Eldivex Inc. All rights reserved.', style: AppTextStyles.caption.copyWith(color: Colors.white38)),
              _LegalLinks(),
            ],
          );
  }
}

class _LegalLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.end,
      spacing: 4,
      runSpacing: 6,
      children: ['Privacy Policy', 'Terms of Service', 'Cookie Policy'].map(
        (l) => InkWell(
          onTap: () {},
          mouseCursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(l, style: AppTextStyles.caption.copyWith(color: Colors.white38)),
          ),
        ),
      ).toList(),
    );
  }
}
