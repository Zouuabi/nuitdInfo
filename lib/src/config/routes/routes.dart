import 'package:flutter/material.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      
      // splash screen case 
      case Routes.login:
        return MaterialPageRoute(
            builder: (BuildContext ctx) => const Placeholder(
                  child: Text('register'),
                ));
      case Routes.register:
        return MaterialPageRoute(
            builder: (BuildContext ctx) => const Placeholder(
                  child: Text('login'),
                ));

      default:
        // naamlou page 404
        return MaterialPageRoute(builder: (ctx) {
          return const Placeholder(
            child: Text('register'),
          );
        });
    }
  }
}
