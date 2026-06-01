import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/models.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({super.key, required this.label, required this.color});

  factory StatusBadge.fromBookingStatus(BookingStatus status) {
    final (label, color) = switch (status) {
      BookingStatus.pending => ('Pending', AppColors.warning),
      BookingStatus.confirmed => ('Confirmed', AppColors.primary),
      BookingStatus.inProgress => ('In Progress', AppColors.accent),
      BookingStatus.completed => ('Completed', AppColors.success),
      BookingStatus.cancelled => ('Cancelled', AppColors.error),
      BookingStatus.noShow => ('No Show', AppColors.secondaryText),
    };
    return StatusBadge(label: label, color: color);
  }

  factory StatusBadge.fromCaregiverStatus(CaregiverStatus status) {
    final (label, color) = switch (status) {
      CaregiverStatus.available => ('Available', AppColors.success),
      CaregiverStatus.busy => ('Busy', AppColors.warning),
      CaregiverStatus.offline => ('Offline', AppColors.secondaryText),
      CaregiverStatus.onLeave => ('On Leave', AppColors.error),
    };
    return StatusBadge(label: label, color: color);
  }

  factory StatusBadge.fromPatientStatus(PatientStatus status) {
    final (label, color) = switch (status) {
      PatientStatus.active => ('Active', AppColors.success),
      PatientStatus.inactive => ('Inactive', AppColors.secondaryText),
      PatientStatus.discharged => ('Discharged', AppColors.warning),
    };
    return StatusBadge(label: label, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color),
          ),
        ],
      ),
    );
  }
}
