import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/task_status.dart';
import 'package:time_planner_mobile/presentation/group/group_screen.dart';
import 'package:time_planner_mobile/presentation/profile/user_profile_screen.dart';
import 'package:time_planner_mobile/presentation/schedule/bloc/calendar_bloc.dart';
import 'package:time_planner_mobile/presentation/schedule/widget/create_task_dialog.dart';
import 'package:time_planner_mobile/presentation/schedule/widget/task_details.dialog.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

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
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background2.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromARGB(162, 0, 53, 94)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Schedule",
            style: TextStyle(color: AppColors.main),
          ),
        ),
        backgroundColor: const Color.fromARGB(37, 0, 0, 0),
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(0),
          color: Colors.transparent,
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  color: AppColors.main,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            context.go(
                              UserProfileScreen.path,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.people,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            context.go(
                              GroupScreen.path,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<CalendarBloc>(),
                            child: CreateTaskDialog(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.main,
                          shape: const CircleBorder(
                              side: BorderSide(
                            color: Colors.black,
                          )),
                          fixedSize: Size(
                              constraints.maxHeight, constraints.maxHeight)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: IntrinsicHeight(
          child: filter || search
              ? filter
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: AppColors.main, width: 2)),
                            heroTag: UniqueKey(),
                            backgroundColor: AppColors.secondary,
                            child: Icon(
                              Icons.group,
                              color: AppColors.main,
                            ),
                            onPressed: () async {
                              setState(() {
                                eventController.updateFilter(
                                  newFilter: (date, events) {
                                    var dayEvents = events.where(
                                      (element) {
                                        return element.date.day == date.day &&
                                            element.date.month == date.month &&
                                            element.date.year == date.year;
                                      },
                                    );
                                    var result = dayEvents.where(
                                      (element) {
                                        var data = element.event as Task;
                                        return data.groupTask;
                                      },
                                    );
                                    return result.toList();
                                  },
                                );
                                filter = false;
                                search = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: AppColors.main, width: 2)),
                            heroTag: UniqueKey(),
                            backgroundColor: AppColors.secondary,
                            child: Icon(
                              Icons.person,
                              color: AppColors.main,
                            ),
                            onPressed: () async {
                              setState(() {
                                eventController.updateFilter(
                                  newFilter: (date, events) {
                                    var dayEvents = events.where(
                                      (element) {
                                        return element.date.day == date.day &&
                                            element.date.month == date.month &&
                                            element.date.year == date.year;
                                      },
                                    );
                                    var result = dayEvents.where(
                                      (element) {
                                        var data = element.event as Task;
                                        return !data.groupTask;
                                      },
                                    );
                                    return result.toList();
                                  },
                                );

                                filter = false;
                                search = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: AppColors.main, width: 2)),
                            heroTag: UniqueKey(),
                            backgroundColor: AppColors.secondary,
                            child: Icon(
                              Icons.filter_alt_off,
                              color: AppColors.main,
                            ),
                            onPressed: () async {
                              setState(() {
                                eventController.updateFilter(
                                  newFilter: (date, events) {
                                    var dayEvents = events.where(
                                      (element) {
                                        return element.date.day == date.day &&
                                            element.date.month == date.month &&
                                            element.date.year == date.year;
                                      },
                                    );
                                    return dayEvents.toList();
                                  },
                                );
                                filter = false;
                                search = false;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: AppColors.main, width: 2)),
                            heroTag: UniqueKey(),
                            backgroundColor: AppColors.secondary,
                            onPressed: () {
                              setState(() {
                                if (minuteHeight < 20) {
                                  minuteHeight += 0.2;
                                }
                              });
                            },
                            child: Icon(
                              Icons.zoom_in,
                              color: AppColors.main,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: AppColors.main, width: 2)),
                            heroTag: UniqueKey(),
                            backgroundColor: AppColors.secondary,
                            onPressed: () {
                              setState(() {
                                if (minuteHeight > 0.8) {
                                  minuteHeight -= 0.2;
                                }
                              });
                            },
                            child: Icon(
                              Icons.zoom_out,
                              color: AppColors.main,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: AppColors.main, width: 2)),
                            heroTag: UniqueKey(),
                            backgroundColor: AppColors.secondary,
                            child: Icon(
                              Icons.search_off,
                              color: AppColors.main,
                            ),
                            onPressed: () async {
                              setState(() {
                                filter = false;
                                search = false;
                              });
                            },
                          ),
                        ),
                      ],
                    )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: AppColors.main, width: 2)),
                        heroTag: UniqueKey(),
                        backgroundColor: AppColors.secondary,
                        child: Icon(
                          Icons.search,
                          color: AppColors.main,
                        ),
                        onPressed: () async {
                          setState(() {
                            filter = false;
                            search = true;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: AppColors.main, width: 2)),
                        heroTag: UniqueKey(),
                        backgroundColor: AppColors.secondary,
                        child: Icon(
                          Icons.filter_alt,
                          color: AppColors.main,
                        ),
                        onPressed: () async {
                          setState(() {
                            filter = true;
                            search = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
        ),
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
              Expanded(
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DayView(
                      keepScrollOffset: true,
                      backgroundColor: Colors.transparent,
                      onEventTap: (events, date) {
                        var x = events.first.event as Task;
                        showAdaptiveDialog(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<CalendarBloc>(),
                            child: TaskDetailsDialog(task: x),
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
                            style: TextStyle(color: AppColors.main),
                          );
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
                                  (events.first.event as Task).status),
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
              ),
            ]);
          },
        ),
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
