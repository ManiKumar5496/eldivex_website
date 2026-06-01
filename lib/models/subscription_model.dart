import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SubscriptionModel extends Equatable {
  final String id;
  final String agencyId;
  final String tier;
  final String status;
  final double monthlyPrice;
  final int billingCycleDay;
  final DateTime currentPeriodStart;
  final DateTime currentPeriodEnd;
  final String? paymentMethodId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubscriptionModel({
    required this.id,
    required this.agencyId,
    required this.tier,
    required this.status,
    required this.monthlyPrice,
    this.billingCycleDay = 1,
    required this.currentPeriodStart,
    required this.currentPeriodEnd,
    this.paymentMethodId,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == 'active' || status == 'trial';

  factory SubscriptionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SubscriptionModel(
      id: doc.id,
      agencyId: data['agencyId'] ?? '',
      tier: data['tier'] ?? 'starter',
      status: data['status'] ?? 'trial',
      monthlyPrice: (data['monthlyPrice'] ?? 0).toDouble(),
      billingCycleDay: data['billingCycleDay'] ?? 1,
      currentPeriodStart: (data['currentPeriodStart'] as Timestamp?)?.toDate() ?? DateTime.now(),
      currentPeriodEnd: (data['currentPeriodEnd'] as Timestamp?)?.toDate() ?? DateTime.now().add(const Duration(days: 30)),
      paymentMethodId: data['paymentMethodId'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'agencyId': agencyId,
        'tier': tier,
        'status': status,
        'monthlyPrice': monthlyPrice,
        'billingCycleDay': billingCycleDay,
        'currentPeriodStart': Timestamp.fromDate(currentPeriodStart),
        'currentPeriodEnd': Timestamp.fromDate(currentPeriodEnd),
        'paymentMethodId': paymentMethodId,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  @override
  List<Object?> get props => [id, agencyId, tier, status];
}
