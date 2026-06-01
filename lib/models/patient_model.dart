import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum PatientStatus { active, inactive, discharged }

class PatientModel extends Equatable {
  final String id;
  final String agencyId;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String? photoUrl;
  final String contactPhone;
  final String? emergencyContact;
  final String? emergencyPhone;
  final String address;
  final List<String> medicalConditions;
  final List<String> medications;
  final List<String> allergies;
  final String? primaryCaregiverId;
  final PatientStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PatientModel({
    required this.id,
    required this.agencyId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.photoUrl,
    required this.contactPhone,
    this.emergencyContact,
    this.emergencyPhone,
    required this.address,
    this.medicalConditions = const [],
    this.medications = const [],
    this.allergies = const [],
    this.primaryCaregiverId,
    this.status = PatientStatus.active,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month || (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  factory PatientModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PatientModel(
      id: doc.id,
      agencyId: data['agencyId'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      dateOfBirth: (data['dateOfBirth'] as Timestamp?)?.toDate() ?? DateTime(1970),
      photoUrl: data['photoUrl'],
      contactPhone: data['contactPhone'] ?? '',
      emergencyContact: data['emergencyContact'],
      emergencyPhone: data['emergencyPhone'],
      address: data['address'] ?? '',
      medicalConditions: List<String>.from(data['medicalConditions'] ?? []),
      medications: List<String>.from(data['medications'] ?? []),
      allergies: List<String>.from(data['allergies'] ?? []),
      primaryCaregiverId: data['primaryCaregiverId'],
      status: PatientStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => PatientStatus.active,
      ),
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'agencyId': agencyId,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': Timestamp.fromDate(dateOfBirth),
        'photoUrl': photoUrl,
        'contactPhone': contactPhone,
        'emergencyContact': emergencyContact,
        'emergencyPhone': emergencyPhone,
        'address': address,
        'medicalConditions': medicalConditions,
        'medications': medications,
        'allergies': allergies,
        'primaryCaregiverId': primaryCaregiverId,
        'status': status.name,
        'notes': notes,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  PatientModel copyWith({
    String? id,
    String? agencyId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? photoUrl,
    String? contactPhone,
    String? emergencyContact,
    String? emergencyPhone,
    String? address,
    List<String>? medicalConditions,
    List<String>? medications,
    List<String>? allergies,
    String? primaryCaregiverId,
    PatientStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PatientModel(
        id: id ?? this.id,
        agencyId: agencyId ?? this.agencyId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        photoUrl: photoUrl ?? this.photoUrl,
        contactPhone: contactPhone ?? this.contactPhone,
        emergencyContact: emergencyContact ?? this.emergencyContact,
        emergencyPhone: emergencyPhone ?? this.emergencyPhone,
        address: address ?? this.address,
        medicalConditions: medicalConditions ?? this.medicalConditions,
        medications: medications ?? this.medications,
        allergies: allergies ?? this.allergies,
        primaryCaregiverId: primaryCaregiverId ?? this.primaryCaregiverId,
        status: status ?? this.status,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [id, agencyId, firstName, lastName, dateOfBirth, status];
}
