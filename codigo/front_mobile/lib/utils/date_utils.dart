import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateUtilsExtension on DateTime {
  bool isSameDate(DateTime? date) {
    if (date != null) {
      return day == date.day && month == date.month && year == date.year;
    }
    return false;
  }

  DateTime copyWith({int? year, int? month, int? day}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
    );
  }

  bool isSameMonth(DateTime date) {
    return month == date.month && year == date.year;
  }

  DateTime previousMonth() {
    return DateTime.utc(year, month - 1, 1);
  }

  DateTime nextMonth() {
    return DateTime.utc(year, month + 1, 1);
  }

  DateTime nextDay() {
    return DateTime.utc(year, month, day + 1);
  }

  DateTime previousDay() {
    return DateTime.utc(year, month, day - 1);
  }

  int monthWeeks() {
    return ((firstDayOfMonth.weekday + 2 + lastDayOfMonth.day) / 7).round();
  }

  DateTime get firstDayOfMonth => DateTime.utc(year, month, 1);

  DateTime get lastDayOfMonth => DateTime.utc(year, month + 1, 0);

  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  int get monthDays => lastDayOfMonth.day;

  bool get isToday => isSameDate(DateTime.now());

  bool get isYesterday => DateTime.now().previousDay().isSameDate(this);

  bool isThisYear() {
    final now = DateTime.now();
    return year == now.year;
  }

  bool isSameWeek(DateTime baseDate) {
    baseDate = DateTime.utc(baseDate.year, baseDate.month, baseDate.day);
    final dayWeekday = baseDate.weekday;
    final differenceDays = difference(baseDate).inDays;
    final weekdayDifference = dayWeekday + differenceDays;

    return (weekdayDifference >= 1) && (weekdayDifference <= 7);
  }

  String format(String format) {
    return DateFormat(format).format(this);
  }

  String prettyFormat(DateTime comparationDate) {
    if (isSameWeek(comparationDate)) {
      if (isToday) {
        return 'TODAY';
      }
      if (isYesterday) {
        return 'YESTERDAY';
      }
      return DateFormat('EEEE').format(this).toUpperCase();
    }
    if (isThisYear()) {
      return DateFormat('E d MMM').format(this).toUpperCase();
    }

    return DateFormat('d MMM yyyy').format(this).toUpperCase();
  }

  String getHour24(DateTime dateTime) {
    return dateTime.hour.toString() +
        ":" +
        dateTime.minute.toString().padLeft(2, '0');
  }

  String get toAmPm => DateFormat.jm().format(this);

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  String toLocalizedDateFormat(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    return localizations.formatCompactDate(this);
  }

  @Deprecated('Use toAmPm instead')
  String getHourAmPm(DateTime dateTime) {
    final format = DateFormat.jm();

    return format.format(dateTime);
  }

  String formattedMonth({bool showYear = false}) {
    final now = DateTime.now();
    if (year != now.year || showYear) {
      return format('MMMM yyyy');
    }
    return format('MMMM');
  }

  String formattedDay() {
    final now = DateTime.now();
    String formattedDate = DateFormat('MMM d, y').format(now);
    if (isSameDate(now)) {
      return 'Today • ' + formattedDate;
    }
    return format('MMM dd, y');
  }

  String formattedMonthCalendarOpen() {
    String formattedDate = format('MMMM, y');
    return formattedDate;
  }

  subtractMonth([int count = 1]) {
    int y = 0;
    int m = 0;
    if (month <= count) {
      y = count % 12 + 1;
    }
    m = count - 12 * y;
    return DateTime(year - y, month - m, day);
  }

  addMonth([int count = 1]) {
    int y = 0;
    int m = 0;
    if (month <= count) {
      y = count % 12 + 1;
    }
    m = count - 12 * y;
    return DateTime(year + y, month + m, day);
  }
}
