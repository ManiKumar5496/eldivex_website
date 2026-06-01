import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum CarePlanStatus { active, review, archived }

class CarePlanTask extends Equatable {
  final String id;
  final String title;
  final String description;
  final String frequency;
  final List<String> assignedDays;
  final String time;
  final bool isCompleted;

  const CarePlanTask({
    required this.id,
    required this.title,
    required this.description,
    this.frequency = 'daily',
    this.assignedDays = const [],
    this.time = '09:00',
    this.isCompleted = false,
  });

  factory CarePlanTask.fromMap(Map<String, dynamic> data) => CarePlanTask(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        frequency: data['frequency'] ?? 'daily',
        assignedDays: List<String>.from(data['assignedDays'] ?? []),
        time: data['time'] ?? '09:00',
        isCompleted: data['isCompleted'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'frequency': frequency,
        'assignedDays': assignedDays,
        'time': time,
        'isCompleted': isCompleted,
      };

  CarePlanTask copyWith({
    String? id,
    String? title,
    String? description,
    String? frequency,
    List<String>? assignedDays,
    String? time,
    bool? isCompleted,
  }) =>
      CarePlanTask(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        frequency: frequency ?? this.frequency,
        assignedDays: assignedDays ?? this.assignedDays,
        time: time ?? this.time,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  @override
  List<Object?> get props => [id, title, isCompleted];
}

class CarePlanModel extends Equatable {
  final String id;
  final String agencyId;
  final String patientId;
  final String createdByUserId;
  final String title;
  final String description;
  final List<CarePlanTask> tasks;
  final List<String> goals;
  final DateTime startDate;
  final DateTime? endDate;
  final CarePlanStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CarePlanModel({
    required this.id,
    required this.agencyId,
    required this.patientId,
    required this.createdByUserId,
    required this.title,
    required this.description,
    this.tasks = const [],
    this.goals = const [],
    required this.startDate,
    this.endDate,
    this.status = CarePlanStatus.active,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  int get completedTaskCount => tasks.where((t) => t.isCompleted).length;
  double get completionPercentage => tasks.isEmpty ? 0 : completedTaskCount / tasks.length;

  factory CarePlanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CarePlanModel(
      id: doc.id,
      agencyId: data['agencyId'] ?? '',
      patientId: data['patientId'] ?? '',
      createdByUserId: data['createdByUserId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      tasks: (data['tasks'] as List<dynamic>? ?? []).map((t) => CarePlanTask.fromMap(t as Map<String, dynamic>)).toList(),
      goals: List<String>.from(data['goals'] ?? []),
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate(),
      status: CarePlanStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => CarePlanStatus.active,
      ),
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'agencyId': agencyId,
        'patientId': patientId,
        'createdByUserId': createdByUserId,
        'title': title,
        'description': description,
        'tasks': tasks.map((t) => t.toMap()).toList(),
        'goals': goals,
        'startDate': Timestamp.fromDate(startDate),
        'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
        'status': status.name,
        'notes': notes,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  CarePlanModel copyWith({
    String? id,
    String? agencyId,
    String? patientId,
    String? createdByUserId,
    String? title,
    String? description,
    List<CarePlanTask>? tasks,
    List<String>? goals,
    DateTime? startDate,
    DateTime? endDate,
    CarePlanStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CarePlanModel(
        id: id ?? this.id,
        agencyId: agencyId ?? this.agencyId,
        patientId: patientId ?? this.patientId,
        createdByUserId: createdByUserId ?? this.createdByUserId,
        title: title ?? this.title,
        description: description ?? this.description,
        tasks: tasks ?? this.tasks,
        goals: goals ?? this.goals,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [id, agencyId, patientId, title, status];
}
