import 'dart:async';

import 'package:doft/src/core/dummy_data.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/routes.dart';
import '../../../../data/data_source/remote_data_source/cloud_firestore.dart';
import '../../../../data/models/load.dart';
import '../widgets/load_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          /// this is just for debugging
          /// TO Remove later
          await CloudFiresore().postLoad(
            {
              'loaddate': '16/26',
              'pickupdate': '56/6',
              'dropdowndate': '26/15',
              'trucktype': 'stafett',
              'broker': 'hedi',
              'telbroker': '23654159',
              'origin': 'NEw one',
              'destination': 'gbeli',
              'price': '100',
              'weigth': '2500',
              'loadRef': '#254564654',
              'description':
                  'write me a description of the product and the price of the product and the price of the product ',
            },
          );
        },
        child: const Icon(
          Icons.add_road_sharp,
          color: Colors.white,
          size: 40,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(
            seconds: 3,
          ));
        },
        child: ListView.builder(
            padding: const EdgeInsets.all(20),

            itemCount: loads.length,
            itemBuilder: (context, index) {
              Load load = Load(
                description: loads[index]['description']!,
                loadRef: loads[index]['loadRef']!,
                price: loads[index]['price']!,
                weigth: loads[index]['weigth']!,
                loadDate: loads[index]['loaddate']!,
                pickUpDate: loads[index]['pickupdate']!,
                dropDownDate: loads[index]['dropdowndate']!,
                truckType: loads[index]['trucktype']!,
                brokerName: loads[index]['broker']!,
                brokerTel: loads[index]['telbroker']!,
                origin: loads[index]['origin']!,
                destination: loads[index]['destination']!,
              );
              return LoadItem(
                detailsButton: () {
                  Navigator.pushNamed(context, Routes.loadDetails,
                      arguments: load);
                },
                load: load,
              );
            }),
      ),
    );
  }
}
