import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:time_planner_mobile/domain/task/model/create_task_dto.dart';
import 'package:time_planner_mobile/presentation/calendar/bloc/calendar_bloc.dart';

class CreateTaskDialog extends StatefulWidget {
  const CreateTaskDialog({super.key});

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
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
            ElevatedButton(
                onPressed: () {
                  if (_startDate == null || _endDate == null) {
                    return;
                  }
                  context.read<CalendarBloc>().add(AddTaskButtonTappedEvent(
                      createTaskDto: CreateTaskDto(
                          name: _nameController.text,
                          notes: _descriptionController.text,
                          plannedStartHour: _startDate!,
                          plannedEndHour: _endDate!)));
                  if (context.mounted) {
                    context.pop();
                  }
                },
                child: const Text("Add"))
          ],
        ),
      )),
    );
  }
}
