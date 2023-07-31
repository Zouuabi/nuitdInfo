import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetChecker {
  Future<bool> isConnected();
}

class InternetCheckerImpl extends InternetChecker {
  @override
  Future<bool> isConnected() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
