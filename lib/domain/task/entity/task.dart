import 'package:time_planner_mobile/domain/task/model/task_status.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';

class Task {
  final String taskUUID;
  final String name;
  final String notes;
  final TaskStatus status;
  final User creator;
  final String? groupId;
  final bool groupTask;
  final DateTime plannedStartHour;
  final DateTime plannedEndHour;
  final DateTime createdAt;

  Task({
    required this.taskUUID,
    required this.name,
    required this.groupTask,
    required this.notes,
    required this.status,
    required this.creator,
    this.groupId,
    required this.plannedStartHour,
    required this.plannedEndHour,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskUUID: json['taskId'],
      name: json['name'],
      notes: json['notes'],
      status: TaskStatus.fromString(json['status']),
      creator: User.fromJson(json['creator']),
      groupId: json['groupId'],
      groupTask: json['groupId'] != null,
      plannedStartHour: DateTime.parse(json['plannedStartHour']).toLocal(),
      plannedEndHour: DateTime.parse(json['plannedEndHour']).toLocal(),
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }

  Task copyWith({
    String? name,
    String? notes,
    DateTime? plannedStartHour,
    DateTime? plannedEndHour,
    TaskStatus? status,
  }) {
    return Task(
        groupTask: groupTask,
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
