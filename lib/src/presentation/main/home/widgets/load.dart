import 'package:flutter/material.dart';

class Load extends StatelessWidget {
  const Load(
      {super.key,
      required this.origin,
      required this.destination,
      required this.truckType,
      this.weight});
  final String origin;
  final String destination;
  final String truckType;
  final int? weight;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
