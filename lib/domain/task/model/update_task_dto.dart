import 'package:time_planner_mobile/domain/task/model/task_status.dart';

class UpdateTaskDto {
  final String? name;
  final String? notes;
  final DateTime? plannedStartHour;
  final DateTime? plannedEndHour;
  final TaskStatus? status;

  UpdateTaskDto({
    this.name,
    this.notes,
    this.plannedStartHour,
    this.plannedEndHour,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
      'plannedStartHour': plannedStartHour?.toIso8601String(),
      'plannedEndHour': plannedEndHour?.toIso8601String(),
      'status': status?.toString(),
    };
  }
}
