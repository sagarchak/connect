import 'package:intl/intl.dart';
import 'package:connect/utils/common_utils.dart';


class DateTimeUtil {
  static List<DateTime> getDaysInBetween(DateTime start, DateTime end) {
    end = end.add(const Duration(days: 1));
    final daysToGenerate = end.difference(start).inDays;
    return List.generate(daysToGenerate, (i) => DateTime(start.year, start.month, start.day + (i)));
  }



  static DateTime parseDateTime_(String? rawDateTime) {
    if (CommonUtils.checkIfNotNull(rawDateTime)) {
      final DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss zzz').parse(rawDateTime!);
      return parsedDate.toLocal();
    }
    return DateTime.now();
  }

  static DateTime parseServerDateTime(String? rawDate, String? rawTime) {
    if (CommonUtils.checkIfNotNull(rawDate) && CommonUtils.checkIfNotNull(rawTime)) {
      String completeDate = rawDate! + ' ' + rawTime!.toUpperCase();
      final DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(completeDate, true);
      return parsedDate;
    }
    return DateTime.now();
  }

  static DateTime parseAddTimesheetServerDateTime(String? rawDate, String? rawTime) {
    if (CommonUtils.checkIfNotNull(rawDate) && CommonUtils.checkIfNotNull(rawTime)) {
      String completeDate = rawDate! + ' ' + rawTime!.toUpperCase();
      final DateTime parsedDate = DateFormat('dd MMM yyyy hh:mm:ss a').parse(completeDate);
      return parsedDate;
    }
    return DateTime.now();
  }

  static String getCurrentClockOutTime(DateTime mClockOutTime) {
    final DateTime now = mClockOutTime.toUtc();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String getCurrentDate() {
    final DateTime now = DateTime.now().toUtc();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String getLocalDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String getOneWeekOldLocalDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    DateTime oneWeekOld = DateTime(now.year, now.month, now.day - 7);

    final String formatted = formatter.format(oneWeekOld);
    return formatted;
  }

  static String getOneMonthOldLocalDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    DateTime oneWeekOld = DateTime(now.year, now.month - 1, now.day);

    final String formatted = formatter.format(oneWeekOld);
    return formatted;
  }

  static String getOneYearOldLocalDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    DateTime oneWeekOld = DateTime(now.year - 1, now.month, now.day);

    final String formatted = formatter.format(oneWeekOld);
    return formatted;
  }

  static String getLocalTime5HourOldWithoutSeconds() {
    final DateTime now = DateTime.now();
    DateTime fiveHourOld = DateTime(now.year, now.month, now.day, now.hour - 5);
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(fiveHourOld);
    return formatted;
  }

  static String getLocalTimeWithoutSeconds() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String getLocalTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('HH:mm:ss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String getServerUTCDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date.toUtc());
    return formatted;
  }

  static String getServerDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getShowDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getShortShowDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getShowTime(DateTime date) {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getServerUTCTime(DateTime date) {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(date.toUtc());
    return formatted;
  }








  static DateTime getAddTimeSheetBreakTime(String? breakTime) {
    DateTime now = DateTime.now();
    if (CommonUtils.checkIfNotNull(breakTime)) {
      final DateTime parsedDate = DateFormat('HH:mm:ss').parse(breakTime!, true);
      return DateTime(now.year, now.month, now.day, parsedDate.hour, parsedDate.minute, parsedDate.second);
    }
    return DateTime(now.year, now.month, now.day, 1, 30, 0);
  }

  static String convertDateTimeToLocalShortDate(DateTime? provided) {
    if (provided != null) {
      final DateFormat formatter = DateFormat('MMM dd');
      final String formatted = formatter.format(provided);
      return formatted;
    }
    return "Invalid date";
  }

  static String convertDateTimeToLocalDate(DateTime? provided) {
    if (provided != null) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(provided);
      return formatted;
    }
    return "Invalid date";
  }

  static String convertDateTimeToLocalTime(DateTime? provided) {
    if (provided != null) {
      final DateFormat formatter = DateFormat('HH:mm');
      final String formatted = formatter.format(provided);
      return formatted;
    }
    return "Invalid date";
  }

  static String convertDateTimeToLocalTime12(DateTime? provided) {
    if (provided != null) {
      final DateFormat formatter = DateFormat('hh:mm a');
      final String formatted = formatter.format(provided);
      return formatted;
    }
    return "Invalid date";
  }

  static String convertDateTimeToLocalDateTime(DateTime provided) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    final String formatted = formatter.format(provided);
    return formatted;
  }

  static String convertDateTimeToLocalDateTimeTimesheet(DateTime provided) {
    final DateFormat formatter = DateFormat('dd MMM yyyy,\nhh:mm a');
    final String formatted = formatter.format(provided);
    return formatted;
  }

  static String convertDateTimeToLocalDateTimeTaskComment(DateTime provided) {
    final DateFormat formatter = DateFormat('dd MMM, HH:mm');
    final String formatted = formatter.format(provided);
    return formatted;
  }

  static String convertDateTimeToLocalDateTimeClockOut(DateTime provided) {
    final DateFormat formatter = DateFormat('dd MMM yyyy, hh:mm a');
    final String formatted = formatter.format(provided);
    return formatted;
  }

  static String parseLocalDateToServerDate(String rawDate) {
    if (CommonUtils.checkIfNotNull(rawDate)) {
      final DateTime now = DateFormat('dd-MM-yyyy').parse(rawDate, true).toUtc();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);
      return formatted;
    }
    return '';
  }

  static String parseLocalTimeToServerTime(String rawDate) {
    if (CommonUtils.checkIfNotNull(rawDate)) {
      final DateTime now = DateFormat('dd-MM-yyyy').parse(rawDate, true).toUtc();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);
      return formatted;
    }
    return '';
  }

  static String parseServerJoiningDate(String rawDate) {
    if (CommonUtils.checkIfNotNull(rawDate)) {
      final DateTime now = DateFormat('yyyy-MM-dd').parse(rawDate);
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);
      return formatted;
    }
    return '';
  }
}
