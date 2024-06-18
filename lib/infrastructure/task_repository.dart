import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/generic_error_details.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client/http_client.dart';

class TaskRepository implements TaskRepositoryAbstraction {
  final HttpClient httpClient;

  TaskRepository({required this.httpClient});

  @override
  Future<Either<RepositoryError, Task>> createTaskForGroup(
      CreateTaskDto dto) async {
    try {
      var result = await httpClient.dio.post("api/task/group", data: dto);
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }
      var task = Task.fromJson(result.data);
      return Right(task);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, Task>> createTaskForUser(
      CreateTaskDto dto) async {
    try {
      var result = await httpClient.dio.post("api/task/user", data: dto);
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }
      var task = Task.fromJson(result.data);
      return Right(task);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, bool>> deleteTask(String uuid) async {
    try {
      var result = await httpClient.dio.delete(
        "api/task/$uuid",
      );
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, List<Task>>> getGroupTasks(String uuid) async {
    try {
      var result = await httpClient.dio.get(
        "api/task/group/$uuid",
      );

      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }
      var output = <Task>[];
      for (var item in result.data) {
        output.add(Task.fromJson(item));
      }
      return Right(output);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, Task?>> getTask(String uuid) async {
    try {
      var result = await httpClient.dio.get(
        "api/task/group/$uuid",
      );

      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }

      return Right(Task.fromJson(result.data));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          return const Right(null);
        }
      }
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, List<Task>>> getUserTasks() async {
    try {
      var result = await httpClient.dio.get(
        "api/task/user",
      );

      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }

      var output = <Task>[];
      for (var item in result.data) {
        output.add(Task.fromJson(item));
      }
      return Right(output);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, Task>> updateTask(
      String uuid, UpdateTaskDto dto) async {
    try {
      var result = await httpClient.dio.put("api/task/$uuid", data: dto);
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }

      var task = Task.fromJson(result.data);
      return Right(task);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }
}
