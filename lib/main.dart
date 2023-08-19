import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/data/data_source/remote_data_source/firebase_options.dart';
import 'src/app.dart';
import 'src/injector.dart';

void main() async {
  await globalInstances();
  profilInstances();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}
