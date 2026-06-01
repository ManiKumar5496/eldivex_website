import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum NotificationType { booking, alert, system, message, reminder }

class NotificationModel extends Equatable {
  final String id;
  final String userId;
  final String agencyId;
  final String title;
  final String body;
  final NotificationType type;
  final String? relatedEntityId;
  final String? relatedEntityType;
  final bool isRead;
  final Map<String, dynamic> data;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.agencyId,
    required this.title,
    required this.body,
    this.type = NotificationType.system,
    this.relatedEntityId,
    this.relatedEntityType,
    this.isRead = false,
    this.data = const {},
    required this.createdAt,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      userId: d['userId'] ?? '',
      agencyId: d['agencyId'] ?? '',
      title: d['title'] ?? '',
      body: d['body'] ?? '',
      type: NotificationType.values.firstWhere(
        (t) => t.name == d['type'],
        orElse: () => NotificationType.system,
      ),
      relatedEntityId: d['relatedEntityId'],
      relatedEntityType: d['relatedEntityType'],
      isRead: d['isRead'] ?? false,
      data: Map<String, dynamic>.from(d['data'] ?? {}),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'agencyId': agencyId,
        'title': title,
        'body': body,
        'type': type.name,
        'relatedEntityId': relatedEntityId,
        'relatedEntityType': relatedEntityType,
        'isRead': isRead,
        'data': data,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        userId: userId,
        agencyId: agencyId,
        title: title,
        body: body,
        type: type,
        relatedEntityId: relatedEntityId,
        relatedEntityType: relatedEntityType,
        isRead: isRead ?? this.isRead,
        data: data,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [id, userId, isRead, createdAt];
}
