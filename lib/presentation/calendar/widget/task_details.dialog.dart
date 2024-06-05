import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';
import 'package:time_planner_mobile/domain/task/model/task_status.dart';
import 'package:time_planner_mobile/domain/task/model/update_task_dto.dart';
import 'package:time_planner_mobile/presentation/calendar/bloc/calendar_bloc.dart';

class TaskDetailsDialog extends StatefulWidget {
  final TaskDto task;
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
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                enabled: edit,
                decoration: const InputDecoration(hintText: "Name"),
                controller: _nameController,
                validator: (value) {
                  if (value == null) {
                    return "Value cannot be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: edit,
                decoration: const InputDecoration(hintText: "Description"),
                controller: _descriptionController,
                validator: (value) {
                  if (value == null) {
                    return "Value cannot be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: edit,
                decoration: const InputDecoration(label: Text("Start Date")),
                controller: _startDateController,
                readOnly: true,
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
              TextFormField(
                enabled: edit,
                decoration: const InputDecoration(label: Text("End Date")),
                controller: _endDateController,
                readOnly: true,
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
              DropdownButton(
                  value: _currentTaskStatus,
                  items: TaskStatus.values
                      .map((e) => DropdownMenuItem<TaskStatus>(
                            value: e,
                            child: Text(e.toPresentativeString()),
                          ))
                      .toList(),
                  onChanged: edit
                      ? (TaskStatus? value) {
                          setState(() {
                            _currentTaskStatus = value;
                          });
                        }
                      : null),
              edit
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
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
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                edit = false;
                              });
                            },
                            icon: const Icon(Icons.close, color: Colors.red))
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          edit = true;
                        });
                      },
                      icon: const Icon(Icons.edit))
            ],
          ),
        ),
      ),
    );
  }
}
