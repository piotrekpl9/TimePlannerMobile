class CreateTaskDto {
  final String name;
  final String notes;
  final DateTime plannedStartHour;
  final DateTime plannedEndHour;

  CreateTaskDto({
    required this.name,
    required this.notes,
    required this.plannedStartHour,
    required this.plannedEndHour,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
      'plannedStartHour': plannedStartHour.toIso8601String(),
      'plannedEndHour': plannedEndHour.toIso8601String(),
    };
  }
}
