import 'package:flutter/material.dart';

class ChooseLocationButton extends StatefulWidget {
  const ChooseLocationButton({
    super.key,
    required this.onlocationschanged,
  });

  final void Function(String location) onlocationschanged;

  @override
  State<ChooseLocationButton> createState() => _ChooseLocationButtonState();
}

class _ChooseLocationButtonState extends State<ChooseLocationButton> {
  List<String> towns = [
    'Tunis',
    'Sfax',
    'Sousse',
    'Kairouan',
    'Bizerte',
    'Gabes',
    'Ariana',
    'Gafsa',
    'Kasserine',
    'Monastir',
    'Tataouine',
    'Medenine',
    'Nabeul',
    'Beja',
    'Ben Arous',
    'Siliana',
    'Jendouba',
    'Mahdia',
    'Kebili',
    'La Manouba',
    'Tozeur',
    'Kef',
    'Zaghouan',
    'Sidi Bouzid',
  ];
  String selectedLocation = 'choose a place';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 400,
      value: selectedLocation,
      items: [
        const DropdownMenuItem(
            value: 'choose a place', child: Text('choose a place')),
        ...(towns
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList())
      ],
      onChanged: (value) {
        if (value != null) {
          widget.onlocationschanged(value);
          setState(() {
            selectedLocation = value;
          });
        }
      },
    );
  }
}
