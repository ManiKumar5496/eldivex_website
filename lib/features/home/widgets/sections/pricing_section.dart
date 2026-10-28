import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../providers/ui_provider.dart';
import '../../../../widgets/common/section_badge.dart';
import '../book_demo_modal.dart';

class PricingSection extends ConsumerWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnnual = ref.watch(pricingAnnualProvider);
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              const SectionBadge(label: 'Pricing'),
              const SizedBox(height: 16),
              Text(AppStrings.pricingTitle, style: isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2, textAlign: TextAlign.center)
                  .animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(AppStrings.pricingSubtitle, style: isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge, textAlign: TextAlign.center)
                  .animate().fadeIn(duration: 600.ms, delay: 100.ms),
              const SizedBox(height: 32),
              _BillingToggle(isAnnual: isAnnual, onToggle: () => ref.read(pricingAnnualProvider.notifier).toggle()),
              const SizedBox(height: 48),
              isMobile
                  ? Column(
                      children: _buildCards(context, isAnnual, mobile: true),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _buildCards(context, isAnnual),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context, bool isAnnual, {bool mobile = false}) {
    return AppStrings.pricingPlans.asMap().entries.map((e) {
      final plan = e.value;
      final highlighted = plan['highlighted'] as bool;
      final card = _PricingCard(
        name: plan['name'] as String,
        price: isAnnual ? plan['annualPrice'] as int : plan['monthlyPrice'] as int,
        description: plan['description'] as String,
        features: List<String>.from(plan['features'] as List),
        highlighted: highlighted,
        isAnnual: isAnnual,
        delay: Duration(milliseconds: e.key * 100),
      );
      if (mobile) return Padding(padding: const EdgeInsets.only(bottom: 20), child: card);
      return Expanded(child: card);
    }).toList();
  }
}

class _BillingToggle extends StatelessWidget {
  final bool isAnnual;
  final VoidCallback onToggle;

  const _BillingToggle({required this.isAnnual, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Tab(label: 'Monthly', selected: !isAnnual, onTap: isAnnual ? onToggle : null),
          _Tab(
            label: 'Annual',
            selected: isAnnual,
            onTap: !isAnnual ? onToggle : null,
            badge: 'Save 20%',
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final String? badge;

  const _Tab({required this.label, required this.selected, this.onTap, this.badge});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow: selected ? [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: AppTextStyles.label.copyWith(color: selected ? AppColors.darkText : AppColors.secondaryText)),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(color: AppColors.success.withAlpha(30), borderRadius: BorderRadius.circular(100)),
                child: Text(badge!, style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PricingCard extends StatefulWidget {
  final String name;
  final int price;
  final String description;
  final List<String> features;
  final bool highlighted;
  final bool isAnnual;
  final Duration delay;

  const _PricingCard({
    required this.name,
    required this.price,
    required this.description,
    required this.features,
    required this.highlighted,
    required this.isAnnual,
    required this.delay,
  });

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: 200.ms,
        margin: EdgeInsets.symmetric(vertical: widget.highlighted ? 0 : 16),
        padding: EdgeInsets.all(isMobile ? 20 : 32),
        decoration: BoxDecoration(
          color: widget.highlighted ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(
            color: widget.highlighted ? AppColors.primary : (_hovered ? AppColors.primary.withAlpha(80) : AppColors.border),
            width: widget.highlighted ? 0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.highlighted
                  ? AppColors.primary.withAlpha(60)
                  : (_hovered ? AppColors.primary.withAlpha(20) : Colors.black.withAlpha(8)),
              blurRadius: widget.highlighted ? 40 : (_hovered ? 24 : 8),
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.highlighted)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withAlpha(30), borderRadius: BorderRadius.circular(100)),
                child: Text('Most Popular', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            if (widget.highlighted) const SizedBox(height: 12),
            Text(
              widget.name,
              style: AppTextStyles.h3.copyWith(color: widget.highlighted ? Colors.white : AppColors.darkText),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: AppTextStyles.bodySmall.copyWith(color: widget.highlighted ? Colors.white70 : AppColors.secondaryText),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${widget.price}',
                  style: AppTextStyles.pricingPrice.copyWith(
                    fontSize: isMobile ? 36 : 48,
                    color: widget.highlighted ? Colors.white : AppColors.darkText,
                  ),
                ),
                Text(
                  '/mo',
                  style: AppTextStyles.body.copyWith(color: widget.highlighted ? Colors.white70 : AppColors.secondaryText),
                ),
              ],
            ),
            if (widget.isAnnual)
              Text(
                'Billed annually',
                style: AppTextStyles.caption.copyWith(color: widget.highlighted ? Colors.white60 : AppColors.secondaryText),
              ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: widget.highlighted
                  ? OutlinedButton(
                      onPressed: () => showBookDemoModal(context, source: 'pricing_${widget.name.toLowerCase()}'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Get Started'),
                    )
                  : ElevatedButton(
                      onPressed: () => showBookDemoModal(context, source: 'pricing_${widget.name.toLowerCase()}'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Get Started'),
                    ),
            ),
            const SizedBox(height: 28),
            ...widget.features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_rounded, size: 18, color: widget.highlighted ? Colors.white : AppColors.success),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          f,
                          style: AppTextStyles.bodySmall.copyWith(color: widget.highlighted ? Colors.white : AppColors.darkText),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms, delay: widget.delay).slideY(begin: 0.15, duration: 600.ms, delay: widget.delay),
    );
  }
}
