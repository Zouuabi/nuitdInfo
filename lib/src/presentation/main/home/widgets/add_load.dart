import 'package:flutter/material.dart';

import '../../../../config/routes/routes.dart';

class AddLoad extends StatelessWidget {
  const AddLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ElevatedButton.icon(
          style: ButtonStyle(
              iconSize: MaterialStateProperty.all(30),
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          onPressed: () {
            Navigator.pushNamed(context, Routes.postLoad);
          },
          icon: const Icon(Icons.add_road),
          label: Text(
            'Add a Load',
            style: Theme.of(context).textTheme.titleLarge,
          )),
    );
  }
}
