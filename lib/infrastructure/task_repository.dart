import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client/http_client.dart';

class TaskRepository implements TaskRepositoryAbstraction {
  final HttpClient httpClient;

  TaskRepository({required this.httpClient});

  @override
  Future<Task?> createTaskForGroup(CreateTaskDto dto) async {
    try {
      var result = await httpClient.dio.post("api/task/group", data: dto);
      if (result.statusCode != 200) {
        return null;
      }
      if (result.data == null) {
        return null;
      }
      var task = Task.fromJson(result.data);
      return task;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Task?> createTaskForUser(CreateTaskDto dto) async {
    try {
      var result = await httpClient.dio.post("api/task/user", data: dto);
      if (result.statusCode != 200) {
        return null;
      }
      if (result.data == null) {
        return null;
      }
      var task = Task.fromJson(result.data);
      return task;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteTask(String uuid) async {
    try {
      var result = await httpClient.dio.delete(
        "api/task/$uuid",
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Task>> getGroupTasks(String uuid) async {
    try {
      var result = await httpClient.dio.get(
        "api/task/group/$uuid",
      );

      if (result.statusCode != 200) {
        return [];
      }
      if (result.data == null) {
        return [];
      }
      var output = <Task>[];
      for (var item in result.data) {
        output.add(Task.fromJson(item));
      }
      return output;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Task?> getTask(String uuid) async {
    try {
      var result = await httpClient.dio.get(
        "api/task/group/$uuid",
      );

      if (result.statusCode != 200) {
        return null;
      }
      if (result.data == null) {
        return null;
      }

      return Task.fromJson(result.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Task>> getUserTasks() async {
    try {
      var result = await httpClient.dio.get(
        "api/task/user",
      );

      if (result.statusCode != 200) {
        return [];
      }
      if (result.data == null) {
        return [];
      }
      var output = <Task>[];
      for (var item in result.data) {
        output.add(Task.fromJson(item));
      }
      return output;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Task?> updateTask(String uuid, UpdateTaskDto dto) async {
    try {
      var result = await httpClient.dio.put("api/task/$uuid", data: dto);
      if (result.statusCode != 200) {
        return null;
      }
      if (result.data == null) {
        return null;
      }
      var task = Task.fromJson(result.data);
      return task;
    } catch (e) {
      return null;
    }
  }
}
