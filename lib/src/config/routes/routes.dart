import 'package:doft/src/presentation/main/post_load/pages/post_load_screen.dart';
import 'package:flutter/material.dart';

import 'package:doft/src/presentation/main/load_details/load_details_screen.dart';
import 'package:doft/src/presentation/register/pages/register_screen.dart';

import '../../data/models/load.dart';
import '../../presentation/login/pages/login_screen.dart';
import '../../presentation/main/main_screen.dart';

import '../../injector.dart';

class Routes {

  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String main = "/main";
  static const String loadDetails = "/loadDetails";
  static const String postLoad = "/postLoad";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // splash screen case
      case Routes.main:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          homeInstances();
          return const MainScreen();
        });

      // **************************
      case Routes.login:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          loginInstances();
          return LoginScreen();
        });

      //************************* */

      case Routes.register:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          registerInstances();
          return const RegisterScreen();
        });

      //************************** */

      case Routes.loadDetails:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          final Load arg = settings.arguments as Load;

          return LoadDetailsScreen(load: arg);
        });

      //************************** */

      case Routes.postLoad:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          postInstances();
          return const PostLoadScreen();
        });
      //************************** */

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
