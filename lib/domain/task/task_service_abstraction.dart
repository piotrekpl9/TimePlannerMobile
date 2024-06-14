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

  Left<ServiceError, T> handleError<T>(RepositoryError error) {
    switch (error.status) {
      case RepositoryErrorStatus.connectionError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.communicationError));

      case RepositoryErrorStatus.requestError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.communicationError));

      case RepositoryErrorStatus.serverError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.serverError));

      case RepositoryErrorStatus.internalError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.applicationError));
    }
  }
}
