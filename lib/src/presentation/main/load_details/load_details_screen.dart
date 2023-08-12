import 'package:flutter/material.dart';

import '../../../data/models/load.dart';
import '../../shared/map_view.dart';
import '../../shared/toggle_farvorite_button.dart';

import 'widgets/details.dart';

class LoadDetailsScreen extends StatelessWidget {
  const LoadDetailsScreen({super.key, required this.load});

  final Load load;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [ToggleFavorites(loadRef: load.loadRef)],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
      //appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // *** kharita
              MapView(size: size),
              const SizedBox(height: 20),

              ToggleFavorites(loadRef: load.loadRef),
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
}
