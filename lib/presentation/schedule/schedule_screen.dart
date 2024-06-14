import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_floating_action_button.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_scaffold.dart';
import 'package:time_planner_mobile/presentation/schedule/bloc/calendar_bloc.dart';
import 'package:time_planner_mobile/presentation/schedule/widget/add_task_button.dart';
import 'package:time_planner_mobile/presentation/schedule/widget/event_tile.dart';
import 'package:time_planner_mobile/presentation/schedule/widget/filter_menu.dart';
import 'package:time_planner_mobile/presentation/schedule/widget/task_details.dialog.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/schedule/widget/zoom_menu.dart';

class ScheduleScreen extends StatefulWidget {
  static String path = "/scheduleScreen";
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var eventController = EventController();
  var minuteHeight = 1.5;
  bool filter = false;
  bool zoom = false;
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentScreenCategory: BottomNavigationBarPage.schedule,
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
          return SafeArea(
            child: Stack(
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Expanded(
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: DayView(
                          keepScrollOffset: true,
                          backgroundColor: Colors.transparent,
                          onEventTap: (events, date) {
                            var task = events.first.event as Task;
                            showAdaptiveDialog(
                              context: context,
                              builder: (ctx) => BlocProvider.value(
                                value: context.read<CalendarBloc>(),
                                child: TaskDetailsDialog(task: task),
                              ),
                            );
                          },
                          headerStyle: HeaderStyle(
                              headerTextStyle: TextStyle(color: AppColors.main),
                              leftIcon: Icon(
                                Icons.chevron_left_outlined,
                                color: AppColors.main,
                              ),
                              rightIcon: Icon(
                                Icons.chevron_right_outlined,
                                color: AppColors.main,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          color: AppColors.main, width: 2)))),
                          showQuarterHours: true,
                          showHalfHours: true,
                          timeLineBuilder: (date) {
                            if (date.minute == 0 || date.minute == 30) {
                              return Text(
                                DateFormat('HH:mm').format(date),
                                style: TextStyle(
                                  color: AppColors.main,
                                ),
                                textAlign: TextAlign.right,
                              );
                            }
                            return const SizedBox();
                          },
                          eventTileBuilder: (date, events, boundary,
                              startDuration, endDuration) {
                            return EventTile(
                                date: date,
                                events: events,
                                endDuration: endDuration,
                                boundary: boundary,
                                startDuration: startDuration);
                          },
                          dateStringBuilder: (date, {secondaryDate}) =>
                              DateFormat('yyyy/MM/dd').format(date),
                          controller: eventController,
                          heightPerMinute: minuteHeight,
                        ),
                      ),
                    ),
                  ),
                ]),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IntrinsicHeight(
                    child: filter || zoom
                        ? filter
                            ? FilterMenu(
                                eventController: eventController,
                                onPressed: () {
                                  setState(() {
                                    filter = false;
                                    zoom = false;
                                  });
                                },
                              )
                            : ZoomMenu(
                                minuteHeight: minuteHeight,
                                onValueChange: (p0) => setState(() {
                                  minuteHeight = p0;
                                }),
                                onCancelPressed: () {
                                  setState(() {
                                    zoom = false;
                                    filter = false;
                                  });
                                },
                              )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MainFloatingActionButton(
                                  onPressed: () async {
                                    setState(() {
                                      filter = false;
                                      zoom = true;
                                    });
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: AppColors.main,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MainFloatingActionButton(
                                  onPressed: () async {
                                    setState(() {
                                      filter = true;
                                      zoom = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.filter_alt,
                                    color: AppColors.main,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const AddTaskButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
