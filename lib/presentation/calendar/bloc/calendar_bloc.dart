import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  CalendarBloc({required this.taskRepository, required this.taskService})
      : super(const CalendarState(status: CalendarStatus.init, tasks: [])) {
    on<UserEnteredScreenEvent>(_userEnteredScreen);
    on<AddTaskButtonTappedEvent>(_addTask);
    on<UpdateTaskButtonTappedEvent>(_updateTask);
  }

  void _userEnteredScreen(
      UserEnteredScreenEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.loading));
    var tasks = await taskRepository.readUserTasks();

    emitter(state.copyWith(status: CalendarStatus.idle, tasks: tasks));
  }

  void _addTask(
      AddTaskButtonTappedEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.creatingEvent));
    var task = await taskService.createTaskForUser(event.createTaskDto);
    if (task != null) {
      var tasks = state.tasks..add(task);
      emitter(state.copyWith(status: CalendarStatus.idle, tasks: tasks));
    }
  }

  void _updateTask(
      UpdateTaskButtonTappedEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.updatingEvent));
    var task =
        await taskService.updateTask(event.taskUUID, event.updateTaskDto);
    if (task != null) {
      var oldTask = state.tasks
          .where((element) => element.taskUUID == event.taskUUID)
          .firstOrNull;
      if (oldTask == null) {
        return;
      }
      state.tasks.remove(oldTask);
      var newTask = oldTask.copyWith(
          name: task.name,
          notes: task.notes,
          plannedEndHour: task.plannedEndHour,
          plannedStartHour: task.plannedStartHour,
          status: task.status);
      var tasks = state.tasks;
      tasks.add(newTask);
      emitter(state.copyWith(status: CalendarStatus.idle, tasks: tasks));
    }
  }
}
