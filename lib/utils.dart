import 'package:flutter/material.dart';

int toMinutes(final TimeOfDay time) => time.hour * 60 + time.minute;

DateTime toDateTime(final TimeOfDay time, [final DateTime? date]) {
  final now = date ?? DateTime.now();
  return DateTime(now.year, now.month, now.day, time.hour, time.minute);
}
