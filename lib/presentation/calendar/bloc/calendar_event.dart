part of 'calendar_bloc.dart';

class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class UserEnteredScreenEvent extends CalendarEvent {}

class AddTaskButtonTappedEvent extends CalendarEvent {
  final CreateTaskDto createTaskDto;

  const AddTaskButtonTappedEvent({required this.createTaskDto});
}

class UpdateTaskButtonTappedEvent extends CalendarEvent {
  final String taskUUID;
  final UpdateTaskDto updateTaskDto;

  const UpdateTaskButtonTappedEvent(
      {required this.taskUUID, required this.updateTaskDto});
}
