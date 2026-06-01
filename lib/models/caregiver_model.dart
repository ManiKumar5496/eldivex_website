import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum CaregiverStatus { available, busy, offline, onLeave }

class CaregiverModel extends Equatable {
  final String id;
  final String userId;
  final String agencyId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? photoUrl;
  final List<String> specializations;
  final List<String> certifications;
  final double hourlyRate;
  final double rating;
  final int totalReviews;
  final CaregiverStatus status;
  final String? bio;
  final int experienceYears;
  final List<String> languages;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CaregiverModel({
    required this.id,
    required this.userId,
    required this.agencyId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.photoUrl,
    this.specializations = const [],
    this.certifications = const [],
    this.hourlyRate = 0.0,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.status = CaregiverStatus.available,
    this.bio,
    this.experienceYears = 0,
    this.languages = const ['English'],
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  factory CaregiverModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CaregiverModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      agencyId: data['agencyId'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      photoUrl: data['photoUrl'],
      specializations: List<String>.from(data['specializations'] ?? []),
      certifications: List<String>.from(data['certifications'] ?? []),
      hourlyRate: (data['hourlyRate'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      totalReviews: data['totalReviews'] ?? 0,
      status: CaregiverStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => CaregiverStatus.available,
      ),
      bio: data['bio'],
      experienceYears: data['experienceYears'] ?? 0,
      languages: List<String>.from(data['languages'] ?? ['English']),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'agencyId': agencyId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'specializations': specializations,
        'certifications': certifications,
        'hourlyRate': hourlyRate,
        'rating': rating,
        'totalReviews': totalReviews,
        'status': status.name,
        'bio': bio,
        'experienceYears': experienceYears,
        'languages': languages,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  CaregiverModel copyWith({
    String? id,
    String? userId,
    String? agencyId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    List<String>? specializations,
    List<String>? certifications,
    double? hourlyRate,
    double? rating,
    int? totalReviews,
    CaregiverStatus? status,
    String? bio,
    int? experienceYears,
    List<String>? languages,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CaregiverModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        agencyId: agencyId ?? this.agencyId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photoUrl: photoUrl ?? this.photoUrl,
        specializations: specializations ?? this.specializations,
        certifications: certifications ?? this.certifications,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        rating: rating ?? this.rating,
        totalReviews: totalReviews ?? this.totalReviews,
        status: status ?? this.status,
        bio: bio ?? this.bio,
        experienceYears: experienceYears ?? this.experienceYears,
        languages: languages ?? this.languages,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [id, userId, agencyId, firstName, lastName, email, phoneNumber, status, rating, hourlyRate];
}
