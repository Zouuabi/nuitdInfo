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
  RepositoryImpl(
      {required this.auth,
      required this.storage,
      required this.firestore,
      required this.internetChecker,
      required this.localStorage});

  final FirebaseAuthentication auth;
  final CloudStorage storage;
  final CloudFiresore firestore;
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
        await auth.signIn(email, password);

        return right(null);
      } catch (e) {
        return Left(Failure(errrorMessage: 'SomeThing Went Wrong'));
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
          uid: usr!.uid,
          email: email,
          userName: username,
          birthDate: birthdate,
          imageLink: urlimage);

      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(errrorMessage: error.code));
    }
  }

  @override
  Future<Either<Failure, List<Load>>> readLoads() async {
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
        await firestore.postLoad(load);
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
      Map<String, dynamic> a = await firestore
          .getCurrentUserInformation(await auth.getCurrentUserId());
      return right(MyUser.fromfirestore(a));
    } catch (e) {
      return left(Failure(errrorMessage: 'user not exist'));
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
        return left(Failure(errrorMessage: 'sdfdsfdsfsdfq'));
      }
    } else {
      return left(Failure(errrorMessage: 'sdfdsfd'));
    }
  }

  @override
  Future<Either<Failure, void>> removeLoadFromFavorites(String loadRef) {
    throw UnimplementedError();
  }
}
