import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum BookingStatus { pending, confirmed, inProgress, completed, cancelled, noShow }

enum ServiceType { personalCare, companionship, medical, transport, housekeeping }

class BookingModel extends Equatable {
  final String id;
  final String agencyId;
  final String patientId;
  final String caregiverId;
  final String? coordinatorId;
  final DateTime startTime;
  final DateTime endTime;
  final BookingStatus status;
  final ServiceType serviceType;
  final String address;
  final double rate;
  final double? totalCost;
  final String? notes;
  final String? cancellationReason;
  final DateTime? checkinTime;
  final DateTime? checkoutTime;
  final int? clientRating;
  final String? clientFeedback;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BookingModel({
    required this.id,
    required this.agencyId,
    required this.patientId,
    required this.caregiverId,
    this.coordinatorId,
    required this.startTime,
    required this.endTime,
    this.status = BookingStatus.pending,
    this.serviceType = ServiceType.personalCare,
    required this.address,
    this.rate = 0.0,
    this.totalCost,
    this.notes,
    this.cancellationReason,
    this.checkinTime,
    this.checkoutTime,
    this.clientRating,
    this.clientFeedback,
    required this.createdAt,
    required this.updatedAt,
  });

  Duration get duration => endTime.difference(startTime);

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      agencyId: data['agencyId'] ?? '',
      patientId: data['patientId'] ?? '',
      caregiverId: data['caregiverId'] ?? '',
      coordinatorId: data['coordinatorId'],
      startTime: (data['startTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endTime: (data['endTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: BookingStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => BookingStatus.pending,
      ),
      serviceType: ServiceType.values.firstWhere(
        (s) => s.name == data['serviceType'],
        orElse: () => ServiceType.personalCare,
      ),
      address: data['address'] ?? '',
      rate: (data['rate'] ?? 0).toDouble(),
      totalCost: data['totalCost']?.toDouble(),
      notes: data['notes'],
      cancellationReason: data['cancellationReason'],
      checkinTime: (data['checkinTime'] as Timestamp?)?.toDate(),
      checkoutTime: (data['checkoutTime'] as Timestamp?)?.toDate(),
      clientRating: data['clientRating'],
      clientFeedback: data['clientFeedback'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'agencyId': agencyId,
        'patientId': patientId,
        'caregiverId': caregiverId,
        'coordinatorId': coordinatorId,
        'startTime': Timestamp.fromDate(startTime),
        'endTime': Timestamp.fromDate(endTime),
        'status': status.name,
        'serviceType': serviceType.name,
        'address': address,
        'rate': rate,
        'totalCost': totalCost,
        'notes': notes,
        'cancellationReason': cancellationReason,
        'checkinTime': checkinTime != null ? Timestamp.fromDate(checkinTime!) : null,
        'checkoutTime': checkoutTime != null ? Timestamp.fromDate(checkoutTime!) : null,
        'clientRating': clientRating,
        'clientFeedback': clientFeedback,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  BookingModel copyWith({
    String? id,
    String? agencyId,
    String? patientId,
    String? caregiverId,
    String? coordinatorId,
    DateTime? startTime,
    DateTime? endTime,
    BookingStatus? status,
    ServiceType? serviceType,
    String? address,
    double? rate,
    double? totalCost,
    String? notes,
    String? cancellationReason,
    DateTime? checkinTime,
    DateTime? checkoutTime,
    int? clientRating,
    String? clientFeedback,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      BookingModel(
        id: id ?? this.id,
        agencyId: agencyId ?? this.agencyId,
        patientId: patientId ?? this.patientId,
        caregiverId: caregiverId ?? this.caregiverId,
        coordinatorId: coordinatorId ?? this.coordinatorId,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        serviceType: serviceType ?? this.serviceType,
        address: address ?? this.address,
        rate: rate ?? this.rate,
        totalCost: totalCost ?? this.totalCost,
        notes: notes ?? this.notes,
        cancellationReason: cancellationReason ?? this.cancellationReason,
        checkinTime: checkinTime ?? this.checkinTime,
        checkoutTime: checkoutTime ?? this.checkoutTime,
        clientRating: clientRating ?? this.clientRating,
        clientFeedback: clientFeedback ?? this.clientFeedback,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [id, agencyId, patientId, caregiverId, startTime, endTime, status];
}
