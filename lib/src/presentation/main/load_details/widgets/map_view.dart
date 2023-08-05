import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: size.height * 0.3,
    );
  }
}
