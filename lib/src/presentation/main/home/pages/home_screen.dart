import 'package:doft/src/core/dummy_data.dart';
import 'package:flutter/material.dart';

import '../widgets/load.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: loads.length,
      itemBuilder: (context, index) {
        return LoadItem(
            load: Load(
                loadDate: loads[index]['loaddate']!,
                pickUpDate: loads[index]['pickupdate']!,
                dropDownDate: loads[index]['dropdowndate']!,
                truckType: loads[index]['trucktype']!,
                brokerName: loads[index]['broker']!,
                brokerTel: loads[index]['telbroker']!,
                origin: loads[index]['origin']!,
                destination: loads[index]['destination']!));
      },
    );
  }
}
