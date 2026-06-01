import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HeroDashboardMockup extends StatelessWidget {
  final bool showFloating;
  const HeroDashboardMockup({super.key, this.showFloating = true});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: 800.ms, delay: 400.ms),
        SlideEffect(begin: const Offset(0.15, 0), duration: 800.ms, delay: 400.ms, curve: Curves.easeOutCubic),
      ],
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _MainDashboardCard(),
          if (showFloating)
            Positioned(
              top: -20,
              right: -24,
              child: _FloatingStatCard(
                label: 'Active Caregivers',
                value: '247',
                icon: Icons.people_rounded,
                color: AppColors.primary,
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(begin: 0, end: -8, duration: 2400.ms, curve: Curves.easeInOut),
            ),
          if (showFloating)
            Positioned(
              bottom: 40,
              left: -28,
              child: _FloatingStatCard(
                label: 'Today\'s Bookings',
                value: '38',
                icon: Icons.calendar_today_rounded,
                color: AppColors.accent,
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(begin: 0, end: -8, duration: 2800.ms, delay: 400.ms, curve: Curves.easeInOut),
            ),
          if (showFloating)
            Positioned(
              bottom: -10,
              right: -16,
              child: _FloatingStatCard(
                label: 'Patient Rating',
                value: '4.9★',
                icon: Icons.star_rounded,
                color: AppColors.success,
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(begin: 0, end: -8, duration: 2200.ms, delay: 800.ms, curve: Curves.easeInOut),
            ),
        ],
      ),
    );
  }
}

class _MainDashboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      constraints: const BoxConstraints(maxWidth: 460),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withAlpha(25), blurRadius: 60, offset: const Offset(0, 20)),
          BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WindowBar(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dashboard Overview', style: AppTextStyles.h4.copyWith(fontSize: 16)),
                const SizedBox(height: 4),
                Text('November 2024', style: AppTextStyles.bodySmall),
                const SizedBox(height: 16),
                Row(children: [
                  _MiniStatCard(label: 'Revenue', value: '\$48.2K', trend: '+12%', color: AppColors.primary),
                  const SizedBox(width: 10),
                  _MiniStatCard(label: 'Patients', value: '1,247', trend: '+8%', color: AppColors.accent),
                  const SizedBox(width: 10),
                  _MiniStatCard(label: 'Care Plans', value: '186', trend: '+5%', color: AppColors.success),
                ]),
                const SizedBox(height: 16),
                Text('Monthly Revenue', style: AppTextStyles.label),
                const SizedBox(height: 8),
                SizedBox(height: 100, child: _RevenueChart()),
                const SizedBox(height: 16),
                _RecentBookingsList(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WindowBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          _Dot(color: const Color(0xFFFF5F57)),
          const SizedBox(width: 6),
          _Dot(color: const Color(0xFFFFBD2E)),
          const SizedBox(width: 6),
          _Dot(color: const Color(0xFF28C840)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(6)),
            child: Text('app.eldivex.io/dashboard', style: AppTextStyles.caption.copyWith(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) => Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _MiniStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final Color color;

  const _MiniStatCard({required this.label, required this.value, required this.trend, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withAlpha(12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: AppTextStyles.h4.copyWith(color: color, fontSize: 16)),
            Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10)),
            Text(trend, style: TextStyle(fontSize: 9, color: AppColors.success, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _RevenueChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 5,
        minY: 30,
        maxY: 60,
        lineBarsData: [
          LineChartBarData(
            spots: const [FlSpot(0, 35), FlSpot(1, 42), FlSpot(2, 38), FlSpot(3, 50), FlSpot(4, 45), FlSpot(5, 55)],
            isCurved: true,
            gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]),
            barWidth: 2.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [AppColors.primary.withAlpha(50), AppColors.accent.withAlpha(5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentBookingsList extends StatelessWidget {
  final _items = const [
    ('Sarah M.', 'Personal Care', '9:00 AM', AppColors.success),
    ('Robert T.', 'Companionship', '11:30 AM', AppColors.primary),
    ('Alice K.', 'Medical Support', '2:00 PM', AppColors.warning),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Bookings', style: AppTextStyles.label),
        const SizedBox(height: 8),
        ..._items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: item.$4, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item.$1, style: AppTextStyles.bodySmall.copyWith(color: AppColors.darkText))),
                  Text(item.$2, style: AppTextStyles.caption),
                  const SizedBox(width: 8),
                  Text(item.$3, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                ],
              ),
            )),
      ],
    );
  }
}

class _FloatingStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _FloatingStatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: AppTextStyles.h4.copyWith(fontSize: 16, color: AppColors.darkText)),
              Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
