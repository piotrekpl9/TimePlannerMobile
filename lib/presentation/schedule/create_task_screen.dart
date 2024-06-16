import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_date_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_scaffold.dart';
import 'package:time_planner_mobile/presentation/schedule/bloc/calendar_bloc.dart';

class CreateTaskScreen extends StatefulWidget {
  static String path = "/create-task";
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  bool groupTask = false;
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  Widget build(BuildContext context) {
    var calendarBloc = context.read<CalendarBloc>();
    return MainScaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(162, 0, 53, 94)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Create Task",
          style: TextStyle(color: AppColors.main),
        ),
      ),
      bottomNavigationBar: const MainBottomNavigationBar(
        activeScreen: BottomNavigationBarPage.schedule,
      ),
      body: BlocListener<CalendarBloc, CalendarState>(
        bloc: calendarBloc,
        listener: (context, state) {
          if (state.status == CalendarStatus.error) {
            Fluttertoast.showToast(
                msg: state.error?.description ?? "Unknown error occured!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.main,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(15),
                color: AppColors.secondary,
              ),
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          size: 54,
                          Icons.edit_note,
                          color: AppColors.main,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GenericFormField(
                          hint: "Name",
                          controller: _nameController,
                          validator: (value) {
                            if (value == null) {
                              return "Value cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GenericFormField(
                          hint: "Description",
                          controller: _descriptionController,
                          validator: (value) {
                            if (value == null) {
                              return "Value cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GenericDateFormField(
                          hint: "Start Date",
                          controller: _startDateController,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2025));
                            if (date == null) return;

                            if (!context.mounted) return;

                            final TimeOfDay? selectedTime =
                                await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(date),
                            );
                            var result = selectedTime == null
                                ? date
                                : DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );

                            if (_endDate != null) {
                              if (result.isAfter(_endDate!)) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Start date cannot be later than end date!")));
                                }
                              }
                              if (result.day != _endDate!.day ||
                                  result.year != _endDate!.year ||
                                  result.month != _endDate!.month) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "End date day cannot be different than start date day!")));
                                setState(() {
                                  _endDate = null;
                                  _endDateController.text = "";
                                });
                              }
                            }

                            setState(() {
                              _startDate = result;
                              _startDateController.text =
                                  DateFormat('yyyy/MM/dd HH:mm').format(result);
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Value cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GenericDateFormField(
                          hint: "End Date",
                          controller: _endDateController,
                          onTap: () async {
                            DateTime? date;
                            if (_startDate != null) {
                              date = _startDate;
                            } else {
                              date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2025));
                            }

                            if (date == null) return;

                            if (!context.mounted) return;

                            final TimeOfDay? selectedTime =
                                await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(date),
                            );

                            var result = selectedTime == null
                                ? date
                                : DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );
                            if (_startDate != null) {
                              if (result.isBefore(_startDate!)) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "End date cannot be earlier than start date!")));
                                  result = _startDate!
                                      .add(const Duration(minutes: 5));
                                }
                              }
                              if (result.day != _startDate!.day ||
                                  result.year != _startDate!.year ||
                                  result.month != _startDate!.month) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "End date day cannot be different than start date day!")));
                                }
                              }
                            }

                            setState(() {
                              _endDate = result;
                              _endDateController.text =
                                  DateFormat('yyyy/MM/dd HH:mm').format(result);
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Value cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IntrinsicWidth(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  checkColor: AppColors.secondary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: AppColors.main, width: 2)),
                                  activeColor: AppColors.main,
                                  value: groupTask,
                                  onChanged: (value) {
                                    if (calendarBloc.state.group == null) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "User is not a member of any group",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      return;
                                    }
                                    setState(() {
                                      groupTask = !groupTask;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Create for group",
                                style: TextStyle(
                                    color: AppColors.main,
                                    fontSize: 20,
                                    decoration: null,
                                    decorationStyle: null,
                                    textBaseline: null),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: MainButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_startDate == null || _endDate == null) {
                                    return;
                                  }
                                  context.read<CalendarBloc>().add(
                                      AddTaskButtonTappedEvent(
                                          groupTask: groupTask,
                                          createTaskDto: CreateTaskDto(
                                              name: _nameController.text,
                                              notes:
                                                  _descriptionController.text,
                                              plannedStartHour: _startDate!,
                                              plannedEndHour: _endDate!)));
                                  if (context.mounted) {
                                    context.pop();
                                  }
                                }
                              },
                              child: Text(
                                "Add",
                                style: TextStyle(color: AppColors.secondary),
                              )),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
