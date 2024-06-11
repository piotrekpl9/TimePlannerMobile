import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_service_abstraction.dart';

import '../domain/task/entity/task.dart';

class TaskService implements TaskServiceAbstraction {
  final TaskRepositoryAbstraction taskRepository;

  TaskService({required this.taskRepository});

  @override
  Future<Task?> createTaskForGroup(CreateTaskDto dto) async {
    return await taskRepository.createTaskForGroup(dto);
  }

  @override
  Future<Task?> createTaskForUser(CreateTaskDto dto) async {
    return await taskRepository.createTaskForUser(dto);
  }

  @override
  Future<bool> deleteTask(String uuid) async {
    return await taskRepository.deleteTask(uuid);
  }

  @override
  Future<Task?> updateTask(String uuid, UpdateTaskDto dto) async {
    return await taskRepository.updateTask(uuid, dto);
  }
}
