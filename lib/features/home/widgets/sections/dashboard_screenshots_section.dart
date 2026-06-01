import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/common/glassmorphism_card.dart';
import '../../../../widgets/common/section_badge.dart';

class DashboardScreenshotsSection extends StatelessWidget {
  const DashboardScreenshotsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ph = ResponsiveUtils.sectionPaddingH(context);
    final pv = ResponsiveUtils.sectionPaddingV(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: ph, vertical: pv),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              SectionBadge(label: 'Dashboard', color: AppColors.accent),
              const SizedBox(height: 16),
              Text('Powerful Tools at Your Fingertips', style: (isMobile ? AppTextStyles.h2Mobile : AppTextStyles.h2).copyWith(color: Colors.white), textAlign: TextAlign.center)
                  .animate()
                  .fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(
                'Get a complete view of your caregiving operations with intuitive dashboards designed for every role.',
                style: (isMobile ? AppTextStyles.body : AppTextStyles.bodyLarge).copyWith(color: Colors.white60),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
              SizedBox(height: isMobile ? 40 : 60),
              isMobile
                  ? Column(
                      children: [
                        _DashboardMockCard(title: 'Admin Dashboard', delay: 0.ms, child: _AdminMock()),
                        const SizedBox(height: 20),
                        _DashboardMockCard(title: 'Booking Calendar', delay: 200.ms, child: _CalendarMock()),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(flex: 6, child: _DashboardMockCard(title: 'Admin Dashboard', delay: 0.ms, child: _AdminMock())),
                        const SizedBox(width: 20),
                        Expanded(flex: 4, child: _DashboardMockCard(title: 'Booking Calendar', delay: 200.ms, child: _CalendarMock())),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardMockCard extends StatefulWidget {
  final String title;
  final Widget child;
  final Duration delay;

  const _DashboardMockCard({required this.title, required this.child, required this.delay});

  @override
  State<_DashboardMockCard> createState() => _DashboardMockCardState();
}

class _DashboardMockCardState extends State<_DashboardMockCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: GlassmorphismCard(
          backgroundColor: Colors.white.withAlpha(15),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(widget.title, style: AppTextStyles.label.copyWith(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              widget.child,
            ],
          ),
        ),
      ).animate().fadeIn(duration: 700.ms, delay: widget.delay).slideY(begin: 0.15, duration: 700.ms, delay: widget.delay),
    );
  }
}

class _AdminMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          _StatTile(label: 'Caregivers', value: '247', color: AppColors.primary),
          const SizedBox(width: 10),
          _StatTile(label: 'Patients', value: '1.2K', color: AppColors.accent),
          const SizedBox(width: 10),
          _StatTile(label: 'Revenue', value: '\$48K', color: AppColors.success),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: BarChart(
            BarChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(
                7,
                (i) => BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: (20 + i * 8 + (i % 3) * 5).toDouble(),
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      width: 18,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatTile({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: AppTextStyles.h4.copyWith(color: Colors.white, fontSize: 16)),
            Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}

class _CalendarMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: days
              .map((d) => Text(d, style: AppTextStyles.caption.copyWith(color: Colors.white60, fontSize: 10)))
              .toList(),
        ),
        const SizedBox(height: 8),
        ...List.generate(
          4,
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                (col) {
                  final day = row * 7 + col + 1;
                  final hasEvent = [3, 7, 10, 12, 15, 18, 21, 24].contains(day);
                  final isToday = day == 15;
                  return Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isToday ? AppColors.primary : (hasEvent ? AppColors.primary.withAlpha(50) : Colors.transparent),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 11,
                          color: isToday ? Colors.white : (hasEvent ? Colors.white : Colors.white38),
                          fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
