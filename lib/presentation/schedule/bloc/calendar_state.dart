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
  final GenericErrorDetails? error;
  const CalendarState(
      {required this.status, required this.tasks, this.group, this.error});

  @override
  List<Object> get props => [status, tasks];
  CalendarState copyWith(
      {CalendarStatus? status,
      List<Task>? tasks,
      Group? group,
      GenericErrorDetails? error}) {
    return CalendarState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
        error: error ?? this.error,
        group: group ?? this.group);
  }
}
