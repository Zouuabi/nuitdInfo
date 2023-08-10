import 'package:doft/src/core/internet_checker.dart';
import 'package:doft/src/data/data_source/local_data_source/local_storage.dart';
import 'package:doft/src/data/data_source/remote_data_source/cloud_firestore.dart';
import 'package:doft/src/data/data_source/remote_data_source/firebase_auth.dart';
import 'package:doft/src/data/data_source/remote_data_source/firebase_storage.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

GlobalInsatances() {
  injector.registerSingleton<LocalStorage>(LocalStorage());
  injector.registerSingleton<InternetCheckerImpl>(InternetCheckerImpl());

  injector.registerSingleton<RepositoryImpl>(RepositoryImpl(
      internetChecker: injector<InternetCheckerImpl>(),
      localStorage: injector<LocalStorage>()));
}
