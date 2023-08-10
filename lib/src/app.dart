import 'package:doft/src/presentation/login/pages/login_screen.dart';
import 'package:doft/src/presentation/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'config/routes/routes.dart';
import 'injector.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          iconTheme: const IconThemeData(color: Colors.teal),
          dividerColor: Colors.teal.shade200,
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.teal,
              onPrimary: Colors.white,
              secondary: Colors.tealAccent,
              onSecondary: Colors.grey,
              error: Colors.red,
              onError: Colors.red,
              background: Colors.black,
              onBackground: Colors.grey,
              surface: Colors.teal,
              onSurface: Colors.white)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // anna donne jeya m stream
            if (snapshot.hasData) {
              // user is logged in => home Screen
              homeInstances();
              return const MainScreen();
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
            return const LoginScreen(); //LoginScreen()
          }
        },
      ),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
