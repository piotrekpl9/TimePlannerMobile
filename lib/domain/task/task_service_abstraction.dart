import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';

abstract class TaskServiceAbstraction {
  Future<bool> createTaskForUser(CreateTaskDto dto);
  Future<bool> createTaskForGroup(CreateTaskDto dto);
  Future<bool> updateTask(String uuid, UpdateTaskDto dto);
  Future<bool> deleteTask(String uuid);
}
