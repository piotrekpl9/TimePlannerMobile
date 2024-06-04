import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';

import '../../../domain/task/entity/task.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final TaskRepositoryAbstraction taskRepository;

  CalendarBloc({required this.taskRepository})
      : super(const CalendarState(status: CalendarStatus.init, tasks: [])) {
    on<UserEnteredScreenEvent>(_userEnteredScreen);
  }

  void _userEnteredScreen(
      UserEnteredScreenEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarStatus.loading));
    var tasks = await taskRepository.readUserTasks();

    emitter(state.copyWith(status: CalendarStatus.idle, tasks: tasks));
  }
}
