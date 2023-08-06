class DateHandler {
  static DateTime convertStringToDate({required String date}) {
    List<String> dateParts = date.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    return DateTime(year, month, day);
  }

  static Duration diffBetween2Dates({
    required DateTime start,
    required DateTime end,
  }) {
    return end.difference(start);
  }

  static String handleAge(Duration age) {
    if (age.inDays > 0) {
      return "${age.inDays} Days";
    } else {
      return 'Today';
    }
  }
}
