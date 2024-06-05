enum TaskStatus {
  notStarted,
  inProgress,
  completed,
  onHold,
  cancelled;

  String toPresentativeString() {
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

  @override
  String toString() {
    switch (this) {
      case TaskStatus.notStarted:
        return 'NotStarted';
      case TaskStatus.inProgress:
        return 'InProgress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.onHold:
        return 'OnHold';
      case TaskStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  static TaskStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "notstarted":
        return notStarted;
      case "inprogress":
        return inProgress;
      case "completed":
        return completed;
      case "onhold":
        return onHold;
      case "cancelled":
        return cancelled;
      default:
        return notStarted;
    }
  }
}
