import 'package:get_it/get_it.dart';
import 'package:time_planner_mobile/application/group_service.dart';
import 'package:time_planner_mobile/application/task_service.dart';
import 'package:time_planner_mobile/application/user_service.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/group/group_service_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_service_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_service_abstraction.dart';

void setupApplicationDependencyInjection(GetIt diContainer) {
  diContainer.registerLazySingleton<GroupServiceAbstraction>(() => GroupService(
      groupRepository: diContainer.get<GroupRepositoryAbstraction>()));
  diContainer.registerLazySingleton<TaskServiceAbstraction>(() => TaskService(
      taskRepository: diContainer.get<TaskRepositoryAbstraction>()));
  diContainer.registerLazySingleton<UserServiceAbstraction>(() => UserService(
      userRepository: diContainer.get<UserRepositoryAbstraction>()));
}
