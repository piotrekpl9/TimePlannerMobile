import 'package:time_planner_mobile/domain/task/model/task_status.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';

class TaskDto {
  final String taskUUID;
  final String name;
  final String notes;
  final TaskStatus status;
  final User creator;
  final String? groupId;
  final DateTime plannedStartHour;
  final DateTime plannedEndHour;
  final DateTime createdAt;

  TaskDto({
    required this.taskUUID,
    required this.name,
    required this.notes,
    required this.status,
    required this.creator,
    this.groupId,
    required this.plannedStartHour,
    required this.plannedEndHour,
    required this.createdAt,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      taskUUID: json['taskId'],
      name: json['name'],
      notes: json['notes'],
      status: TaskStatus.fromString(json['status']),
      creator: User.fromJson(json['creator']),
      groupId: json['groupId'],
      plannedStartHour: DateTime.parse(json['plannedStartHour']).toLocal(),
      plannedEndHour: DateTime.parse(json['plannedEndHour']).toLocal(),
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }

  TaskDto copyWith({
    String? name,
    String? notes,
    DateTime? plannedStartHour,
    DateTime? plannedEndHour,
    TaskStatus? status,
  }) {
    return TaskDto(
        taskUUID: taskUUID,
        name: name ?? this.name,
        notes: notes ?? this.notes,
        status: status ?? this.status,
        creator: creator,
        plannedStartHour: plannedStartHour ?? this.plannedStartHour,
        plannedEndHour: plannedEndHour ?? this.plannedEndHour,
        createdAt: createdAt);
  }
}
