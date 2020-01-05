class CAppConverter {
  static String fromTimeToString(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  static DateTime fromStringToTime(String dateTime) {
    return DateTime.parse("1970-01-01 $dateTime:00.00");
  }

  static String fromDatetimeToString(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  static DateTime fromStringToDatetime(String dateTime) {
    return DateTime.parse("$dateTime 00:00:00.00");
  }
}
