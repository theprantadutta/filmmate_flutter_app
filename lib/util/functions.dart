import 'package:intl/intl.dart';

String formatSpecialDate(DateTime date) {
  // Function to determine the suffix for the day
  String daySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  // Create a DateFormat for the month and year
  DateFormat monthYearFormat = DateFormat('MMMM, yyyy');
  // Get the day with suffix
  String day = date.day.toString();
  String suffix = daySuffix(date.day);

  // Return the formatted date string
  return '$day$suffix ${monthYearFormat.format(date)}';
}
