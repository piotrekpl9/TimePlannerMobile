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
  const CalendarState({required this.status, required this.tasks});

  @override
  List<Object> get props => [status, tasks];
  CalendarState copyWith({CalendarStatus? status, List<Task>? tasks}) {
    return CalendarState(
        status: status ?? this.status, tasks: tasks ?? this.tasks);
  }
}