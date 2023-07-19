import 'package:flutter/material.dart';
import 'package:doft/Widgets/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: Color.fromARGB(255, 251, 252, 252), // Custom primary color
          ),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
        themeMode: ThemeMode.dark);
  }
}
