import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum UserRole { admin, caregiver, coordinator, client }

class UserModel extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final UserRole role;
  final String? phoneNumber;
  final String? agencyId;
  final bool isActive;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.role,
    this.phoneNumber,
    this.agencyId,
    this.isActive = true,
    this.isEmailVerified = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      role: UserRole.values.firstWhere(
        (r) => r.name == data['role'],
        orElse: () => UserRole.client,
      ),
      phoneNumber: data['phoneNumber'],
      agencyId: data['agencyId'],
      isActive: data['isActive'] ?? true,
      isEmailVerified: data['isEmailVerified'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'email': email,
        'displayName': displayName,
        'photoUrl': photoUrl,
        'role': role.name,
        'phoneNumber': phoneNumber,
        'agencyId': agencyId,
        'isActive': isActive,
        'isEmailVerified': isEmailVerified,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    UserRole? role,
    String? phoneNumber,
    String? agencyId,
    bool? isActive,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        photoUrl: photoUrl ?? this.photoUrl,
        role: role ?? this.role,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        agencyId: agencyId ?? this.agencyId,
        isActive: isActive ?? this.isActive,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, role, phoneNumber, agencyId, isActive, isEmailVerified, createdAt, updatedAt];
}
