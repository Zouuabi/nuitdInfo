import 'package:flutter/material.dart' show showDatePicker, BuildContext;

Future<DateTime?> pickDate(BuildContext ctx) async {
  DateTime firestDate = DateTime(1950, 12, 31, 0, 0, 0, 0, 0);
  DateTime now = DateTime.now();

  return await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: firestDate,
      lastDate: now);
}
