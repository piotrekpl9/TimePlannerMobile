import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';

abstract class TaskRepositoryAbstraction {
  Future<Task?> createTaskForUser(CreateTaskDto dto);
  Future<Task?> createTaskForGroup(CreateTaskDto dto);
  Future<Task?> updateTask(String uuid, UpdateTaskDto dto);

  Future<Task?> readTask(String uuid);
  Future<List<Task>> readUserTasks();
  Future<List<Task>> readGroupTasks(String uuid);

  Future<bool> deleteTask(String uuid);
}
