import 'package:doft/src/presentation/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'config/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // anna donne jeya m stream
            if (snapshot.hasData) {
              // user is logged in => home Screen
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
            return const MainScreen(); //LoginScreen()
          }
        },
      ),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
