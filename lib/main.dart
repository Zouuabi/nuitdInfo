import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/data/data_source/remote_data_source/firebase_options.dart';

import 'src/app.dart';

import 'src/injector.dart';

void main() async {
  await globalInstances();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}
// // Define a function that takes three optional variables and a list of loads
// List<Load> filterLoads ({String? origin, String? destination, String? type, required List<Load> loadList}) {
//   // Use the where method to filter the list based on the variables
//   List<Load> filteredList = loadList.where ( (load) {
//     // Use logical operators and null checks to combine the conditions
//     return (origin == null || load.origin == origin) && (destination == null || load.destination == destination) && (type == null || load.type == type);
//   }).toList (); // Convert the iterable to a list

//   // Return the filtered list
//   return filteredList;
// }
