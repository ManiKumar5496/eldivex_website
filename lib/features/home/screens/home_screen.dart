import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/site_links.dart';
import '../../../providers/ui_provider.dart';
import '../home_sections.dart';
import '../widgets/sections/navbar_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/features_section.dart';
import '../widgets/sections/dashboard_screenshots_section.dart';
import '../widgets/sections/how_it_works_section.dart';
import '../widgets/sections/benefits_section.dart';
import '../widgets/sections/industries_section.dart';
import '../widgets/sections/testimonials_section.dart';
import '../widgets/sections/pricing_section.dart';
import '../widgets/sections/security_section.dart';
import '../widgets/sections/cta_banner_section.dart';
import '../widgets/sections/footer_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 60;
    final current = ref.read(navbarScrolledProvider);
    if (scrolled != current) {
      ref.read(navbarScrolledProvider.notifier).setScrolled(scrolled);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          _WhatsAppFab(),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const HeroSection(),
                KeyedSubtree(key: HomeSections.features, child: const FeaturesSection()),
                const DashboardScreenshotsSection(),
                const HowItWorksSection(),
                const BenefitsSection(),
                KeyedSubtree(key: HomeSections.solutions, child: const IndustriesSection()),
                const TestimonialsSection(),
                KeyedSubtree(key: HomeSections.pricing, child: const PricingSection()),
                KeyedSubtree(key: HomeSections.security, child: const SecuritySection()),
                const CtaBannerSection(),
                KeyedSubtree(key: HomeSections.contact, child: const FooterSection()),
              ],
            ),
          ),
          // Sticky navbar overlaid on top
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavbarSection(),
          ),
        ],
      ),
    );
  }
}

class _WhatsAppFab extends StatelessWidget {
  const _WhatsAppFab();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Chat with us on WhatsApp',
      child: FloatingActionButton.extended(
        onPressed: () => SiteLinks.openWhatsApp(source: 'fab'),
        backgroundColor: const Color(0xFF25D366),
        icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 22),
        label: const Text(
          'Chat with us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }
}
