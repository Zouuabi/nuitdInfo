import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mouvema/src/presentation/main/main_screen.dart';

import 'package:mouvema/src/presentation/main/on_boarding/pages/welcome.dart';

import 'config/routes/routes.dart';
import 'config/themes/themes.dart';
import 'injector.dart';
import 'package:device_preview/device_preview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: buildTheme(context: context, light: true),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              homeInstances();

              return MainScreen();
            } else if (snapshot.hasError) {
              return const Text('famma error');
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            loginInstances();

            return const WelcomePage();
          }
        },
      ),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
