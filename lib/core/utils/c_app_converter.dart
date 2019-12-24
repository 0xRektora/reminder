class CAppConverter {
  static String fromDatetimeToString(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  static DateTime fromStringToDatetime(String dateTime) {
    return DateTime.parse("1970-01-01 $dateTime:00.00");
  }
}
