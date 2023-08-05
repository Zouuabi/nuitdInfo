import 'dart:async';

import 'package:doft/src/core/failure.dart';
import 'package:doft/src/data/data_source/remote_data_source/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../core/internet_checker.dart';
import '../../domain/repositories/repositories.dart';
import '../data_source/remote_data_source/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../data_source/remote_data_source/firebase_storage.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl(
      {required this.auth, required this.storage, required this.firestore});

  final FirebaseAuthentication auth;
  final FirebaseStr storage;
  final CloudFiresore firestore;
  final InternetCheckerImpl internetChecker = InternetCheckerImpl();

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.signIn(email, password);
        return const Right(null);
      } on FirebaseAuthException catch (error) {
        return Left(Failure(errrorMessage: error.code));
      }
    } else {
      return Left(Failure(errrorMessage: 'There is no ineternet'));
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
        print('image not null');
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
}
