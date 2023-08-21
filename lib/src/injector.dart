import 'package:get_it/get_it.dart';
import 'package:mouvema/src/presentation/login/cubit/login_cubit.dart';
import 'package:mouvema/src/presentation/main/home/cubit/home_cubit.dart';
import 'package:mouvema/src/presentation/main/my_loads/cubits/post_load_cubit.dart';
import 'package:mouvema/src/presentation/main/fill_profil/cubit/fill_profile_cubit.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_cubit.dart';
import 'package:mouvema/src/presentation/register/cubit/register_cubit.dart';
import 'core/internet_checker.dart';
import 'data/data_source/local_data_source/local_storage.dart';
import 'data/data_source/remote_data_source/cloud_firestore.dart';
import 'data/data_source/remote_data_source/firebase_auth.dart';
import 'data/data_source/remote_data_source/firebase_storage.dart';
import 'data/repository/repository_impl.dart';

GetIt instance = GetIt.instance;

Future<void> globalInstances() async {
  instance.registerLazySingleton<LocalStorage>(() => LocalStorage());
  instance
      .registerLazySingleton<InternetCheckerImpl>(() => InternetCheckerImpl());

  instance.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthentication());

  instance.registerLazySingleton<CloudFiresore>(() => CloudFiresore());

  instance.registerLazySingleton<CloudStorage>(() => CloudStorage());

  instance.registerLazySingleton<RepositoryImpl>(() =>
      RepositoryImpl(localStorage: instance(), internetChecker: instance()));
}

void loginInstances() {
  if (!GetIt.I.isRegistered<LoginScreenCubit>()) {
    instance
        .registerFactory<LoginScreenCubit>(() => LoginScreenCubit(instance()));
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

void profilInstances() {
  if (!GetIt.I.isRegistered<ProfileCubit>()) {
    instance.registerFactory<ProfileCubit>(() => ProfileCubit(instance()));
  }
}

void fillProfileInstances() {
  if (!GetIt.I.isRegistered<FillProfilCubit>()) {
    instance
        .registerFactory<FillProfilCubit>(() => FillProfilCubit(instance()));
  }
}
