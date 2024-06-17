import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/application/service_base.dart';
import 'package:time_planner_mobile/domain/common/service_error.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_service_abstraction.dart';

import '../domain/task/entity/task.dart';

class TaskService extends ServiceBase implements TaskServiceAbstraction {
  final TaskRepositoryAbstraction taskRepository;

  TaskService({required this.taskRepository});

  @override
  Future<Either<ServiceError, Task>> createTaskForGroup(
      CreateTaskDto dto) async {
    var result = await taskRepository.createTaskForGroup(dto);

    return handleGenericResponse<Task>(result);
  }

  @override
  Future<Either<ServiceError, Task>> createTaskForUser(
      CreateTaskDto dto) async {
    var result = await taskRepository.createTaskForUser(dto);

    return handleGenericResponse<Task>(result);
  }

  @override
  Future<Either<ServiceError, bool>> deleteTask(String uuid) async {
    var result = await taskRepository.deleteTask(uuid);

    return handleGenericResponse<bool>(result);
  }

  @override
  Future<Either<ServiceError, Task>> updateTask(
      String uuid, UpdateTaskDto dto) async {
    var result = await taskRepository.updateTask(uuid, dto);

    return handleGenericResponse<Task>(result);
  }
}
