import 'package:flutter/material.dart' show showDatePicker, BuildContext;

Future<DateTime?> pickDate(BuildContext ctx) async {
  DateTime date = DateTime(DateTime.now().year - 18);
  return await showDatePicker(
      context: ctx,
      initialDate: date,
      firstDate: DateTime(1950),
      lastDate: date);
}
