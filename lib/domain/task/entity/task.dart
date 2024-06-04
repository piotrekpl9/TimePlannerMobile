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
}
