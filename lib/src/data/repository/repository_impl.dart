import 'dart:async';

import 'package:doft/src/core/failure.dart';
import 'package:doft/src/data/data_source/remote_data_source/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../core/internet_checker.dart';
import '../../domain/repositories/repositories.dart';
import '../data_source/local_data_source/local_storage.dart';
import '../data_source/remote_data_source/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../data_source/remote_data_source/firebase_storage.dart';
import '../models/load.dart';
import '../models/user.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl({required this.internetChecker, required this.localStorage});

  final FirebaseAuthentication auth = FirebaseAuthentication();
  final CloudStorage storage = CloudStorage();
  final CloudFiresore firestore = CloudFiresore();

  final InternetCheckerImpl internetChecker;
  final LocalStorage localStorage;

  List<Load> _toLoad(List<Map<String, dynamic>> listmaps) {
    return listmaps.map((e) {
      return Load.fromfirestore(e);
    }).toList();
  }

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.signIn(email: email, password: password);

        return right(null);
      } on FirebaseAuthException catch (e) {
        print('ye samir rani error fel impl => auth.');
        return Left(Failure(errrorMessage: e.code));
      }
    } else {
      return Left(Failure(errrorMessage: ' There is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.logOut();
        return right(null);
      } on FirebaseAuthException catch (error) {
        return left(Failure(errrorMessage: error.code));
      }
    } else {
      return Left(Failure(errrorMessage: ' There is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> register(
      {required String username,
      required String birthdate,
      required String email,
      required String password,
      required Uint8List? image}) async {
    String urlimage = '';
    try {
      User? usr = await auth.register(email, password);
      if (image != null) {
        urlimage = await storage.storeImage(
            child: 'usersProfileImages', uid: usr!.uid, image: image);
      }
      await firestore.addNewUserInformations(
          tel: 'mazzel na9ess',
          uid: usr!.uid,
          email: email,
          username: username,
          favoriteLoads: [],
          birdhdate: birthdate,
          imageLink: urlimage);

      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(errrorMessage: error.code));
    }
  }

  @override
  Future<Either<Failure, List<Load?>>> readLoads() async {
    if (await internetChecker.isConnected()) {
      try {
        List<Map<String, dynamic>> list = await firestore.readLoads();
        var listz = _toLoad(list);

        return (right(listz));
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    }
    return left(Failure(errrorMessage: 'There is no internet connection'));
  }

  @override
  Future<Either<Failure, void>> postLoad(Map<String, dynamic> load) async {
    if (await internetChecker.isConnected()) {
      try {
        await firestore.postLoad(load, await auth.getCurrentUserId());
        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: 'Something Went Wrong'));
      }
    } else {
      return left(Failure(errrorMessage: 'There is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, MyUser>> getCurrentUserInformation() async {
    try {
      var usr = await auth.getCurrentUserId();
      Map<String, dynamic> a = await firestore.getCurrentUserInformation(usr);

      return right(MyUser.fromfirestore(a));
    } catch (e) {
      return left(Failure(errrorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addLoadToFavorites(String loadRef) async {
    if (await internetChecker.isConnected()) {
      try {
        await firestore.addToFavorites(
            loadRef: loadRef, uid: await auth.getCurrentUserId());

        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    } else {
      return left(Failure(errrorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> removeLoadFromFavorites(String loadRef) async {
    if (await internetChecker.isConnected()) {
      try {
        await firestore.removeFromFavorites(
            loadRef: loadRef, uid: await auth.getCurrentUserId());

        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: 'remove load from favorite error'));
      }
    } else {
      return left(Failure(errrorMessage: 'remove load from favorite error'));
    }
  }

  @override
  Future<Either<Failure, List<Load>>> readFavoriteLoads() async {
    if (await internetChecker.isConnected()) {
      Map<String, dynamic> user = await firestore
          .getCurrentUserInformation(await auth.getCurrentUserId());
      try {
        List<Load> favoriteLoads =
            await firestore.readFavoriteLoads(MyUser.fromfirestore(user));
        return right(favoriteLoads);
      } catch (e) {
        return left(Failure(errrorMessage: 'Something went wrong ,Try Later'));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Load>>> readMyLoads() async {
    if (await internetChecker.isConnected()) {
      try {
        List<Load> loads = await firestore.fetchMyLoads(
            brokerUid: await auth.getCurrentUserId());
        return right(loads);
      } catch (e) {
        return left(Failure(errrorMessage: 'Some thing Went Wrong'));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> continueWithGoogle() async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.signInWithGoogle();
        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFirstTime() async {
    if (await internetChecker.isConnected()) {
      bool f = await firestore.isFirstTime(await auth.getCurrentUserId());
      print('impl $f');
      return right(f);
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }
}
