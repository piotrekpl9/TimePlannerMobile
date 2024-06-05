import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/task_status.dart';
import 'package:time_planner_mobile/presentation/calendar/bloc/calendar_bloc.dart';
import 'package:time_planner_mobile/presentation/calendar/widget/create_task_dialog.dart';
import 'package:time_planner_mobile/presentation/calendar/widget/task_details.dialog.dart';

class CalendarScreen extends StatefulWidget {
  static String path = "/calendarScreen";
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var eventController = EventController();
  var minuteHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await showAdaptiveDialog(
            context: context,
            builder: (ctx) {
              return BlocProvider.value(
                value: context.read<CalendarBloc>(),
                child: const CreateTaskDialog(),
              );
            },
          );
        },
      ),
      appBar: AppBar(),
      body: BlocConsumer<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>(),
        listener: (context, state) {
          if (state.status != CalendarStatus.creatingTask) {
            eventController.removeWhere(
              (element) => true,
            );
            eventController.addAll(state.tasks.map(
              (e) {
                return CalendarEventData(
                  event: e,
                  title: e.name,
                  date: e.plannedStartHour,
                  startTime: e.plannedStartHour,
                  endTime: e.plannedEndHour,
                );
              },
            ).toList());
          }
        },
        builder: (context, state) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (minuteHeight < 20) {
                          minuteHeight += 0.2;
                        }
                      });
                    },
                    child: const Icon(Icons.zoom_in)),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (minuteHeight > 0.8) {
                          minuteHeight -= 0.2;
                        }
                      });
                    },
                    child: const Icon(Icons.zoom_out)),
              ],
            ),
            Expanded(
              child: IntrinsicHeight(
                child: DayView(
                  onEventTap: (events, date) {
                    var x = events.first.event as TaskDto;
                    showAdaptiveDialog(
                        context: context,
                        builder: (ctx) => BlocProvider.value(
                              value: context.read<CalendarBloc>(),
                              child: TaskDetailsDialog(task: x),
                            ));
                  },
                  showQuarterHours: true,
                  showHalfHours: true,
                  timeLineBuilder: (date) {
                    if (date.minute == 0 || date.minute == 30) {
                      return Text(DateFormat('HH:mm').format(date));
                    }
                    return const SizedBox();
                  },
                  eventTileBuilder:
                      (date, events, boundary, startDuration, endDuration) {
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: getTileColor(
                              (events.first.event as TaskDto).status),
                        ),
                        child: Center(
                            child: Text(
                          events.first.title,
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                    );
                  },
                  dateStringBuilder: (date, {secondaryDate}) =>
                      DateFormat('yyyy/MM/dd').format(date),
                  controller: eventController,
                  heightPerMinute: minuteHeight,
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }

  Color getTileColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.notStarted:
        return Colors.blue;
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
