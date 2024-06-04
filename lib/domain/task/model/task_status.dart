enum TaskStatus {
  notStarted,
  inProgress,
  completed,
  onHold,
  cancelled;

  @override
  String toString() {
    switch (this) {
      case TaskStatus.notStarted:
        return 'Not Started';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.onHold:
        return 'On Hold';
      case TaskStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
