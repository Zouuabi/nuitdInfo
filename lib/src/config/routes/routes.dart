import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/blog/widgets/article.dart';
import '../../data/models/article.dart';
import '../../presentation/blog/pages/detais.dart';

import '../../data/models/load.dart';
import '../../injector.dart';
import '../../presentation/forgot_password/pages/forgot_password_screen.dart';
import '../../presentation/login/pages/login_screen.dart';
import '../../presentation/login/pages/login_with_password.dart';
import '../../presentation/main/load_details/load_details_screen.dart';
import '../../presentation/main/main_screen.dart';
import '../../presentation/main/post_load/pages/post_load_screen.dart';
import '../../presentation/main/profile/pages/profile_screen.dart';
import '../../presentation/register/pages/register_screen.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String loginWithPassword = "/loginWithPassword";
  static const String register = "/register";
  static const String forgotPassword = "/forgortPassword";

  static const String main = "/main";
  static const String loadDetails = "/loadDetails";
  static const String postLoad = "/postLoad";
  static const String fillProfil = "/fillProfil";
  static const String profil = "/Profil";
  static const String mapScreen = "/mapScreen";
  static const String articleDetails = "/articleDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // login screen
      case Routes.login:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const LoginScreen();
        });
      // login With password
      case Routes.loginWithPassword:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const LoginWithPassword();
        });
      // main screen
      case Routes.main:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          homeInstances();
          return const MainScreen();
        });
      // forgot password
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const ForgotPasswordScreen();
        });

      // **************************
      case Routes.articleDetails:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          final Article arg = settings.arguments as Article;
          return Details(articleItem: arg);
        });

      case Routes.profil:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const ProfileScreen();
        });

      //************************* */

      case Routes.register:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const RegisterScreen();
        });

      //************************** */

      case Routes.loadDetails:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          final Load arg = settings.arguments as Load;
          return LoadDetailsScreen(load: arg);
        });

      //************************** */

      //************************** */
      case Routes.postLoad:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return PostLoadScreen();
        });
      default:
        // naamlou page 404
        return MaterialPageRoute(builder: (ctx) {
          return const Placeholder(
            child: Text('404 Not Found'),
          );
        });
    }
  }
}
