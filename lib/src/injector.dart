import 'package:doft/src/data/data_source/local_data_source/local_storage.dart';
import 'package:doft/src/data/data_source/remote_data_source/cloud_firestore.dart';
import 'package:doft/src/data/data_source/remote_data_source/firebase_auth.dart';
import 'package:doft/src/data/data_source/remote_data_source/firebase_storage.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/presentation/login/cubit/login_cubit.dart';
import 'package:doft/src/presentation/main/home/cubit/home_cubit.dart';
import 'package:doft/src/presentation/main/post_load/cubits/post_load_cubit.dart';

import 'package:get_it/get_it.dart';

import 'core/internet_checker.dart';
import 'domain/repositories/repositories.dart';
import 'presentation/register/cubit/register_cubit.dart';

GetIt instance = GetIt.instance;

Future<void> globalInstances() async {
  instance.registerLazySingleton<LocalStorage>(() => LocalStorage());
  instance
      .registerLazySingleton<InternetCheckerImpl>(() => InternetCheckerImpl());

  instance.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthentication());

  instance.registerLazySingleton<CloudFiresore>(() => CloudFiresore());

  instance.registerLazySingleton<CloudStorage>(() => CloudStorage());

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
      auth: instance(),
      storage: instance(),
      firestore: instance(),
      localStorage: instance(),
      internetChecker: instance()));
}

void loginInstances() {
  if (!GetIt.I.isRegistered<LoginCubit>()) {
    instance.registerFactory<LoginCubit>(() => LoginCubit(instance()));
  }
}

void registerInstances() {
  if (!GetIt.I.isRegistered<RegisterCubit>()) {
    instance.registerFactory<RegisterCubit>(() => RegisterCubit(instance()));
  }
}

void homeInstances() {
  if (!GetIt.I.isRegistered<HomeCubit>()) {
    instance.registerFactory<HomeCubit>(() => HomeCubit(instance()));
  }
}

void postInstances() {
  if (!GetIt.I.isRegistered<PostCubit>()) {
    instance.registerFactory<PostCubit>(() => PostCubit(instance()));
  }
}
