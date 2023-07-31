import 'package:flutter/material.dart';

import 'src/config/routes/routes.dart';
import 'src/presentation/login/login_screen.dart';
import 'src/config/themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myThemeData(),
      home: const LoginScreen(),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
