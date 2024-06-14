import 'package:calendar_view/calendar_view.dart';
import 'package:time_planner_mobile/domain/task/entity/task.dart';

List<CalendarEventData<Object?>> userFilter(
    DateTime date, List<CalendarEventData<Object?>> events) {
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
}
