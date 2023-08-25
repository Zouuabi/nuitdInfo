import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/login/pages/login_screen.dart';
import 'package:mouvema/src/presentation/main/main_screen.dart';

import 'config/routes/routes.dart';
import 'config/themes/themes.dart';
import 'injector.dart';
import 'package:device_preview/device_preview.dart';

import 'presentation/main/test.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: buildTheme(context),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // anna donne jeya m stream
            if (snapshot.hasData) {
              // user is logged in => home Screen
              homeInstances();
              fillProfileInstances();
              testInstance();
              return const MapWithSearchBar();
            } else if (snapshot.hasError) {
              return const Text('famma error');
            }
            // naamel vazet l'errror
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // nkharjou dora dour
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            loginInstances();
            homeInstances();
            return const LoginScreen(); //LoginScreen()
          }
        },
      ),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
