import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AgencyModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String? logoUrl;
  final String? website;
  final String subscriptionTier;
  final String subscriptionStatus;
  final int maxCaregivers;
  final int maxPatients;
  final DateTime? subscriptionEndDate;
  final Map<String, bool> features;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AgencyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    this.logoUrl,
    this.website,
    this.subscriptionTier = 'starter',
    this.subscriptionStatus = 'trial',
    this.maxCaregivers = 25,
    this.maxPatients = 50,
    this.subscriptionEndDate,
    this.features = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgencyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AgencyModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      logoUrl: data['logoUrl'],
      website: data['website'],
      subscriptionTier: data['subscriptionTier'] ?? 'starter',
      subscriptionStatus: data['subscriptionStatus'] ?? 'trial',
      maxCaregivers: data['maxCaregivers'] ?? 25,
      maxPatients: data['maxPatients'] ?? 50,
      subscriptionEndDate: (data['subscriptionEndDate'] as Timestamp?)?.toDate(),
      features: Map<String, bool>.from(data['features'] ?? {}),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'logoUrl': logoUrl,
        'website': website,
        'subscriptionTier': subscriptionTier,
        'subscriptionStatus': subscriptionStatus,
        'maxCaregivers': maxCaregivers,
        'maxPatients': maxPatients,
        'subscriptionEndDate': subscriptionEndDate != null ? Timestamp.fromDate(subscriptionEndDate!) : null,
        'features': features,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  AgencyModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? logoUrl,
    String? website,
    String? subscriptionTier,
    String? subscriptionStatus,
    int? maxCaregivers,
    int? maxPatients,
    DateTime? subscriptionEndDate,
    Map<String, bool>? features,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AgencyModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        logoUrl: logoUrl ?? this.logoUrl,
        website: website ?? this.website,
        subscriptionTier: subscriptionTier ?? this.subscriptionTier,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        maxCaregivers: maxCaregivers ?? this.maxCaregivers,
        maxPatients: maxPatients ?? this.maxPatients,
        subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
        features: features ?? this.features,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [id, name, email, subscriptionTier, subscriptionStatus];
}
