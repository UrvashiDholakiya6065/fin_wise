String formatTime(String dateTime) {
  DateTime dt = DateTime.parse(dateTime);
  return "${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
}