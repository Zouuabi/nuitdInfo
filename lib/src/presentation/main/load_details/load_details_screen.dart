import 'package:flutter/material.dart';

import '../../../data/models/load.dart';
import 'widgets/details.dart';
import 'widgets/map_view.dart';

class LoadDetailsScreen extends StatelessWidget {
  const LoadDetailsScreen({super.key, required this.load});

  final Load load;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
      appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // *** kharita
              MapView(size: size),
              const SizedBox(height: 20),
              Details(
                load: load,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(load.origin.toUpperCase()),
          const SizedBox(width: 10),
          const Icon(
            Icons.arrow_right_alt,
            size: 60,
          ),
          const SizedBox(width: 10),
          Text(load.destination.toUpperCase()),
        ],
      ),
      centerTitle: true,
    );
  }
}
