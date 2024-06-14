import 'package:calendar_view/calendar_view.dart';

List<CalendarEventData<Object?>> allFilter(
    DateTime date, List<CalendarEventData<Object?>> events) {
  var dayEvents = events.where(
    (element) {
      return element.date.day == date.day &&
          element.date.month == date.month &&
          element.date.year == date.year;
    },
  );
  return dayEvents.toList();
}
