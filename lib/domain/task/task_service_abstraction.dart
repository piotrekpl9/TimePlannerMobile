import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/common/service_error.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';

abstract class TaskServiceAbstraction {
  Future<Either<ServiceError, Task>> createTaskForUser(CreateTaskDto dto);
  Future<Either<ServiceError, Task>> createTaskForGroup(CreateTaskDto dto);
  Future<Either<ServiceError, Task>> updateTask(String uuid, UpdateTaskDto dto);
  Future<Either<ServiceError, bool>> deleteTask(String uuid);
}
