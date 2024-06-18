import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';

abstract class TaskRepositoryAbstraction {
  Future<Either<RepositoryError, Task>> createTaskForUser(CreateTaskDto dto);
  Future<Either<RepositoryError, Task>> createTaskForGroup(CreateTaskDto dto);
  Future<Either<RepositoryError, Task>> updateTask(
      String uuid, UpdateTaskDto dto);

  Future<Either<RepositoryError, Task?>> getTask(String uuid);
  Future<Either<RepositoryError, List<Task>>> getUserTasks();
  Future<Either<RepositoryError, List<Task>>> getGroupTasks(String uuid);

  Future<Either<RepositoryError, bool>> deleteTask(String uuid);
}
