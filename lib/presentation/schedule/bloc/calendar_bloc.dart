import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/common/generic_error_details.dart';
import 'package:time_planner_mobile/domain/group/entity/group.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_service_abstraction.dart';

import '../../../domain/task/entity/task.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final TaskRepositoryAbstraction taskRepository;
  final TaskServiceAbstraction taskService;
  final GroupRepositoryAbstraction groupRepository;

  CalendarBloc(
      {required this.taskRepository,
      required this.taskService,
      required this.groupRepository})
      : super(const CalendarState(status: CalendarStatus.init, tasks: [])) {
    on<UserEnteredScreenEvent>(_userEnteredScreen);
    on<AddTaskButtonTappedEvent>(_addTask);
    on<UpdateTaskButtonTappedEvent>(_updateTask);
    on<DeleteTaskButtonTappedEvent>(_deleteTask);
  }

  void _userEnteredScreen(
      UserEnteredScreenEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.loading));
    var result = await taskRepository.getUserTasks();
    var group = await groupRepository.getGroup();

    if (result.isLeft || group.isLeft) {
      emitter(state.copyWith(
          status: CalendarStatus.idle, error: result.left.errorDetails));
      return;
    }

    emitter(state.copyWith(
        status: CalendarStatus.idle, tasks: result.right, group: group.right));
  }

  void _addTask(
      AddTaskButtonTappedEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.creatingTask));
    var result = event.groupTask
        ? await taskService.createTaskForGroup(event.createTaskDto)
        : await taskService.createTaskForUser(event.createTaskDto);
    if (result.isRight) {
      add(UserEnteredScreenEvent());
    } else {
      emitter(state.copyWith(
          status: CalendarStatus.idle, error: result.left.errorDetails));
    }
  }

  void _updateTask(
      UpdateTaskButtonTappedEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.updatingTask));
    var result =
        await taskService.updateTask(event.taskUUID, event.updateTaskDto);
    if (result.isRight) {
      var oldTask = state.tasks
          .where((element) => element.taskUUID == event.taskUUID)
          .firstOrNull;
      if (oldTask == null) {
        return;
      }

      var tasks = state.tasks;
      tasks.remove(oldTask);
      var newTask = oldTask.copyWith(
          name: result.right.name,
          notes: result.right.notes,
          plannedEndHour: result.right.plannedEndHour,
          plannedStartHour: result.right.plannedStartHour,
          status: result.right.status);

      tasks.add(newTask);
      emitter(state.copyWith(status: CalendarStatus.idle, tasks: tasks));
    } else {
      emitter(state.copyWith(
          status: CalendarStatus.idle, error: result.left.errorDetails));
    }
  }

  void _deleteTask(
      DeleteTaskButtonTappedEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.deletingTask));
    var result = await taskRepository.deleteTask(event.taskUUID);
    var tasks = state.tasks;
    if (result.isRight) {
      tasks.removeWhere((element) => element.taskUUID == event.taskUUID);
    } else {
      emitter(state.copyWith(
          status: CalendarStatus.error, error: result.left.errorDetails));
    }
    emitter(state.copyWith(status: CalendarStatus.idle, tasks: tasks));
  }
}
