import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/task_status.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class EventTile extends StatelessWidget {
  final DateTime date;
  final List<CalendarEventData<Object?>> events;
  final Rect boundary;
  final DateTime startDuration;
  final DateTime endDuration;
  const EventTile(
      {super.key,
      required this.date,
      required this.events,
      required this.endDuration,
      required this.boundary,
      required this.startDuration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: getTileColor((events.first.event as Task).status),
        ),
        child: Center(
            child: Text(
          events.first.title,
          style: TextStyle(color: AppColors.secondary),
        )),
      ),
    );
  }

  Color getTileColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.notStarted:
        return AppColors.main;
      case TaskStatus.inProgress:
        return Colors.orange;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.onHold:
        return Colors.yellow;
      case TaskStatus.cancelled:
        return Colors.red;
    }
  }
}
