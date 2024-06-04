import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';

abstract class TaskRepositoryAbstraction {
  Future<TaskDto?> createTaskForUser(CreateTaskDto dto);
  Future<TaskDto?> createTaskForGroup(CreateTaskDto dto);
  Future<TaskDto?> updateTask(String uuid, UpdateTaskDto dto);

  Future<TaskDto?> readTask(String uuid);
  Future<List<TaskDto>> readUserTasks();
  Future<List<TaskDto>> readGroupTasks(String uuid);

  Future<bool> deleteTask(String uuid);
}
