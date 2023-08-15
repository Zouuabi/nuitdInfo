import 'package:doft/src/config/themes/themes.dart';
import 'package:doft/src/presentation/login/pages/login_screen.dart';
import 'package:doft/src/presentation/main/main_screen.dart';
import 'package:doft/src/presentation/register/pages/register_screen.dart';
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
      theme: buildTheme(),
      // theme: ThemeData.light().copyWith(
      //     textTheme: TextTheme().copyWith(),
      //     colorScheme: const ColorScheme(
      //         brightness: Brightness.light,
      //         primary: Colors.teal,
      //         onPrimary: Colors.white,
      //         secondary: Color.fromARGB(255, 64, 207, 192),
      //         onSecondary: Colors.white,
      //         error: Colors.red,
      //         onError: Colors.white,
      //         background: Colors.white,
      //         onBackground: Colors.black,
      //         surface: Colors.black,
      //         onSurface: Colors.black)),
      // ThemeData.dark().copyWith(
      //     iconTheme: const IconThemeData(color: Colors.teal),
      //     appBarTheme: const AppBarTheme(
      //         backgroundColor: Color.fromARGB(66, 61, 58, 58)),
      //     dividerColor: Colors.teal.shade200,
      //     colorScheme: const ColorScheme(
      //         brightness: Brightness.dark,
      //         primary: Colors.teal,
      //         onPrimary: Colors.white,
      //         secondary: Colors.tealAccent,
      //         onSecondary: Colors.grey,
      //         error: Colors.red,
      //         onError: Colors.red,
      //         background: Colors.black,
      //         onBackground: Colors.grey,
      //         surface: Colors.teal,
      //         onSurface: Colors.white)),
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
            homeInstances();
            return const MainScreen(); //LoginScreen()
          }
        },
      ),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
