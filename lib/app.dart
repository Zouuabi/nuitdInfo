import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'src/config/routes/routes.dart';
import 'src/presentation/login/pages/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myThemeData(),
         
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // anna donne jeya m stream
            if (snapshot.hasData) {
              // user is logged in => home Screen
              return Container();
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
            return const LoginScreen();
          }
        },
      ),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
