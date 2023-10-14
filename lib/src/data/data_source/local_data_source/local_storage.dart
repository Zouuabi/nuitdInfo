import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  Future<void> storeUser(Map<String, dynamic> user) async {
    var userBox = await Hive.openBox('user');

    await userBox.putAll(user);
    userBox.close();
  }

  Future<dynamic> getUserInformation() async {
    var userBox = await Hive.openBox('user');
    return await userBox.getAt(0);
  }

//final userBox = await Hive.openBox<MyUser>('userBox');
// final loadBox = await Hive.openBox<Load>('loadBox');
}
