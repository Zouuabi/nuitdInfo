// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectTruckType extends StatefulWidget {
  const SelectTruckType({
    super.key,
    required this.onTypeChanged,
  });

  final void Function(String type) onTypeChanged;

  @override
  State<SelectTruckType> createState() => _SelectTruckTypeState();
}

class _SelectTruckTypeState extends State<SelectTruckType> {
  String value = 'Any';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(20),
      iconSize: 30,
      value: value,
      items: const [
        DropdownMenuItem(value: 'Any', child: Center(child: Text('Any'))),
        DropdownMenuItem(
          value: 'camiona',
          child: TruckType(imagePath: 'assets/images/camiona.svg'),
        ),
        DropdownMenuItem(
          value: 'trab',
          child: TruckType(imagePath: 'assets/images/trab.svg'),
        ),
        DropdownMenuItem(
          value: 'semi',
          child: TruckType(imagePath: 'assets/images/semi.svg'),
        ),
      ],
      onChanged: (selectedValue) {
        widget.onTypeChanged(selectedValue ?? value);
        setState(() {
          value = selectedValue ?? value;
        });
      },
    );
  }
}

class TruckType extends StatelessWidget {
  const TruckType({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
    );
  }
}
