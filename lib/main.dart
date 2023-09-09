import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

import 'src/data/data_source/remote_data_source/firebase_options.dart';
import 'src/injector.dart';

void main() async {
  await globalInstances();

  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // // koll box lezmou adapbter bech nsajlou dart objects tool
  // Hive.registerAdapter(UserAdapter());
  // Hive.registerAdapter(LoadAdapter());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}
