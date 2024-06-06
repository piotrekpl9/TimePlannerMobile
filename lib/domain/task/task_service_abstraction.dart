import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';

abstract class TaskServiceAbstraction {
  Future<TaskDto?> createTaskForUser(CreateTaskDto dto);
  Future<TaskDto?> createTaskForGroup(CreateTaskDto dto);
  Future<TaskDto?> updateTask(String uuid, UpdateTaskDto dto);
  Future<bool> deleteTask(String uuid);
}
