import 'package:intl/intl.dart';

import '../dtos/pagination_dto.dart';

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

String truncateText(
  String text, {
  int maxLength = 450,
}) {
  if (text.length <= maxLength) {
    return text;
  }

  // Find the last space within the limit
  int endIndex = text.lastIndexOf(' ', maxLength);
  if (endIndex == -1) {
    // If there's no space, just truncate normally (this handles the edge case where a word is longer than maxLength)
    endIndex = maxLength;
  }

  return '${text.substring(0, endIndex)}...';
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

bool hasNextPage(PaginationDto pagination) {
  int pageNumber = pagination.pageNumber;
  int pageSize = pagination.pageSize;
  int totalItemCount = pagination.totalItemCount;

  int maxItemsCurrentPage = pageNumber * pageSize;
  return totalItemCount > maxItemsCurrentPage;
}

int compareVersion(String v1, String v2) {
  List<int> parseVersion(String version) {
    return version.split('.').map(int.parse).toList();
  }

  final v1Parts = parseVersion(v1);
  final v2Parts = parseVersion(v2);

  final maxLength =
      v1Parts.length > v2Parts.length ? v1Parts.length : v2Parts.length;

  for (var i = 0; i < maxLength; i++) {
    final v1Part = i < v1Parts.length ? v1Parts[i] : 0;
    final v2Part = i < v2Parts.length ? v2Parts[i] : 0;

    if (v1Part < v2Part) return -1;
    if (v1Part > v2Part) return 1;
  }

  return 0;
}
