import 'package:flutter/material.dart';

import '../../../../injector.dart';
import '../../../shared/choose_location_button.dart';
import '../../../shared/select_truck_type.dart';

class AppBarz extends StatelessWidget {
  const AppBarz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mouvema'),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      String? origin, destination, type;
                      return AlertDialog(
                          title: const Text(
                            'Filter',
                          ),
                          content: SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Origin'),
                                    ChooseLocationButton(
                                        onlocationschanged: (originz) {
                                      origin = originz;
                                    }),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Destination'),
                                    ChooseLocationButton(
                                        onlocationschanged: (destinationz) {
                                      destination = destinationz;
                                    }),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Truck Type'),
                                    SelectTruckType(
                                      onTypeChanged: (typez) {
                                        type = typez;
                                      },
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
                                child: const Text('Search'))
                          ]);
                    });
              },
              icon: const Icon(Icons.filter_alt_outlined, size: 30)),
        ],
      ),
      floating: true,
      elevation: 4,
    );
  }
}
