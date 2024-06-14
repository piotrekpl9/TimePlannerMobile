part of 'calendar_bloc.dart';

enum CalendarStatus {
  init,
  loading,
  idle,
  creatingTask,
  updatingTask,
  deletingTask
}

class CalendarState extends Equatable {
  final CalendarStatus status;
  final List<Task> tasks;
  final Group? group;
  const CalendarState({required this.status, required this.tasks, this.group});

  @override
  List<Object> get props => [status, tasks];
  CalendarState copyWith(
      {CalendarStatus? status, List<Task>? tasks, Group? group}) {
    return CalendarState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
        group: group ?? this.group);
  }
}
