import 'package:doft/src/presentation/register/pages/register_screen.dart';
import 'package:flutter/material.dart';

import '../../presentation/home/home_screen.dart';
import '../../presentation/login/pages/login_screen.dart';

class Routes {
  // mehouch tw
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // splash screen case
      case Routes.home:
        return MaterialPageRoute(
            builder: (BuildContext ctx) => const HomeScreen());
      case Routes.login:
        return MaterialPageRoute(
            builder: (BuildContext ctx) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(
            builder: (BuildContext ctx) => const RegisterScreen());

      default:
        // naamlou page 404
        return MaterialPageRoute(builder: (ctx) {
          return const Placeholder(
            child: Text('404'),
          );
        });
    }
  }
}
