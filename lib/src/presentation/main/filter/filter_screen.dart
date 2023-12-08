import 'package:flutter/material.dart';

import '../../shared/choose_location_button.dart';
import '../../shared/select_truck_type.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({
    super.key,
    required this.onOriginSelected,
    required this.onDestinationSelected,
    required this.onTruckSelected,
  });
  final void Function(String) onOriginSelected;
  final void Function(String) onDestinationSelected;
  final void Function(String) onTruckSelected;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.sizeOf(context);
    return AlertDialog(
        title: const Text('Filtrer'),
        content: SizedBox(
          height: screen.height * 0.4,
          width: screen.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Origine'),
                  ChooseLocationButton(onlocationschanged: onOriginSelected),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Destination'),
                  ChooseLocationButton(
                      onlocationschanged: onDestinationSelected),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Type de camion'),
                  SelectTruckType(
                    onTypeChanged: onTruckSelected,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                // instance<HomeCubit>().filterLoads(
                //     destination: destination,
                //     origin: origin,
                //     type: type);
                Navigator.pop(context);
              },
              child: const Text('Rechercher'))
        ]);
  }
}
