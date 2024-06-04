import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/presentation/calendar/bloc/calendar_bloc.dart';

class CalendarScreen extends StatefulWidget {
  static String path = "/calendarScreen";
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>(),
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...state.tasks.map(
                  (e) => Text(
                      "${e.name} ${DateFormat('HH:mm').format(e.plannedStartHour)} ${DateFormat('HH:mm').format(e.plannedEndHour)}"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
