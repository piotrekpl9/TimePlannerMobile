import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/task_status.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_date_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/schedule/bloc/calendar_bloc.dart';

class TaskDetailsDialog extends StatefulWidget {
  final Task task;
  const TaskDetailsDialog({super.key, required this.task});

  @override
  State<TaskDetailsDialog> createState() => _TaskDetailsDialogState();
}

class _TaskDetailsDialogState extends State<TaskDetailsDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  bool edit = false;
  TaskStatus? _currentTaskStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    _nameController.text = widget.task.name;
    _descriptionController.text = widget.task.notes;
    _currentTaskStatus = widget.task.status;
    _startDateController.text =
        DateFormat('yyyy/MM/dd HH:mm').format(widget.task.plannedEndHour);
    _endDateController.text =
        DateFormat('yyyy/MM/dd HH:mm').format(widget.task.plannedEndHour);
    _startDate = widget.task.plannedStartHour;
    _endDate = widget.task.plannedEndHour;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.secondary,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.main,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                size: 54,
                Icons.edit_note,
                color: AppColors.main,
              ),
              SizedBox(
                height: 10,
              ),
              GenericFormField(
                hint: "Name",
                enabled: edit,
                controller: _nameController,
                validator: (value) {
                  if (value == null) {
                    return "Value cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              GenericFormField(
                hint: "Description",
                enabled: edit,
                controller: _descriptionController,
                validator: (value) {
                  if (value == null) {
                    return "Value cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              GenericDateFormField(
                hint: "Start Date",
                enabled: edit,
                controller: _startDateController,
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2025));
                  if (date == null) return;

                  if (!context.mounted) return;

                  final TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(date),
                  );
                  var reesult = selectedTime == null
                      ? date
                      : DateTime(
                          date.year,
                          date.month,
                          date.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                  setState(() {
                    _startDate = reesult;
                    _startDateController.text =
                        DateFormat('yyyy/MM/dd HH:mm').format(reesult);
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Value cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              GenericDateFormField(
                hint: "End Date",
                enabled: edit,
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

                  final TimeOfDay? selectedTime = await showTimePicker(
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
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "EndDate cannot be earlier than StartDate!")));
                        result = _startDate!.add(const Duration(minutes: 5));
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
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.main),
                      contentPadding: const EdgeInsets.all(15),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 164, 155, 135),
                              width: 3)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: edit
                                  ? AppColors.main
                                  : const Color.fromARGB(255, 164, 155, 135),
                              width: 3)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.main, width: 3)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.main, width: 3))),
                  value: _currentTaskStatus,
                  dropdownColor: AppColors.secondary,
                  isExpanded: true,
                  items: TaskStatus.values
                      .map((e) => DropdownMenuItem<TaskStatus>(
                            value: e,
                            child: Text(
                              e.toPresentativeString(),
                              style: TextStyle(color: AppColors.main),
                            ),
                          ))
                      .toList(),
                  onChanged: edit
                      ? (TaskStatus? value) {
                          setState(() {
                            _currentTaskStatus = value;
                          });
                        }
                      : null),
              SizedBox(
                height: 20,
              ),
              edit
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MainButton(
                            onPressed: () {
                              context.read<CalendarBloc>().add(
                                  UpdateTaskButtonTappedEvent(
                                      updateTaskDto: UpdateTaskDto(
                                          status: _currentTaskStatus,
                                          name: _nameController.text,
                                          notes: _descriptionController.text,
                                          plannedStartHour: _startDate!,
                                          plannedEndHour: _endDate!),
                                      taskUUID: widget.task.taskUUID));
                              setState(() {
                                edit = false;
                              });
                              context.pop();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(
                                Icons.done,
                                color: AppColors.secondary,
                              ),
                            )),
                        MainButton(
                            onPressed: () {
                              setState(() {
                                edit = false;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(
                                Icons.close,
                                color: AppColors.secondary,
                              ),
                            ))
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MainButton(
                            onPressed: () {
                              setState(() {
                                edit = true;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.secondary,
                              ),
                            )),
                        MainButton(
                            onPressed: () {
                              context.read<CalendarBloc>().add(
                                  DeleteTaskButtonTappedEvent(
                                      taskUUID: widget.task.taskUUID));
                              context.pop();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(
                                Icons.delete,
                                color: AppColors.secondary,
                              ),
                            )),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
