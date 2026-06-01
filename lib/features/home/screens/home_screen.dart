import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/ui_provider.dart';
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
          // _CallFab(),
          // SizedBox(height: 12),
          _WhatsAppFab(),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: const [
                HeroSection(),
                FeaturesSection(),
                DashboardScreenshotsSection(),
                HowItWorksSection(),
                BenefitsSection(),
                IndustriesSection(),
                TestimonialsSection(),
                PricingSection(),
                SecuritySection(),
                CtaBannerSection(),
                FooterSection(),
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

class _CallFab extends StatelessWidget {
  const _CallFab();

  static const _phone = '7416917249';

  Future<void> _launch(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: _phone));
    final uri = Uri.parse('tel:+91$_phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Number copied & opening dial pad'),
          backgroundColor: const Color(0xFF1E293B),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Call us: +91 74169 17249',
      child: FloatingActionButton(
        heroTag: 'call_fab',
        onPressed: () => _launch(context),
        backgroundColor: const Color(0xFF2563EB),
        child: const Icon(Icons.call_rounded, color: Colors.white, size: 24),
      ),
    );
  }
}

class _WhatsAppFab extends StatelessWidget {
  const _WhatsAppFab();

  static const _message =
      'Hello! I came across Eldivex and I\'m interested in learning more about your healthcare caregiving platform. '
      'Could you please share details about the features, pricing, and how it can benefit my organization? '
      'I would love to schedule a demo at your earliest convenience. Thank you!';

  Future<void> _launch() async {
    final uri = Uri.parse(
      'https://wa.me/917416917249?text=${Uri.encodeComponent(_message)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Chat with us on WhatsApp',
      child: FloatingActionButton.extended(
        onPressed: _launch,
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
