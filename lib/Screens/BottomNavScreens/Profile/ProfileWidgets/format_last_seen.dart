import 'package:intl/intl.dart';

String formatLastSeen(DateTime time) {
  final now = DateTime.now();

  final isToday =
      now.year == time.year &&
          now.month == time.month &&
          now.day == time.day;

  final isYesterday =
      now.subtract(Duration(days: 1)).year == time.year &&
          now.subtract(Duration(days: 1)).month == time.month &&
          now.subtract(Duration(days: 1)).day == time.day;

  if (isToday) {
    return "today at ${DateFormat('hh:mm a').format(time)}";
  } else if (isYesterday) {
    return "yesterday at ${DateFormat('hh:mm a').format(time)}";
  } else {
    return "${DateFormat('EEEE').format(time)} at ${DateFormat('hh:mm a').format(time)}";
  }
}