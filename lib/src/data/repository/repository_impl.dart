import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mouvema/src/data/models/article.dart';

import '../../core/failure.dart';
import '../../core/internet_checker.dart';
import '../../domain/repositories/repositories.dart';
import '../data_source/local_data_source/local_storage.dart';
import '../data_source/remote_data_source/cloud_firestore.dart';
import '../data_source/remote_data_source/firebase_auth.dart';
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
        return Left(Failure(errrorMessage: e.code));
      }
    } else {
      return Left(Failure(errrorMessage: ' There is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, MyUser>> getCurrentUserInformation() async {
    if (await internetChecker.isConnected()) {
      try {
        var user = await firestore
            .getCurrentUserInformation(await auth.getCurrentUserId());

        return right(MyUser.fromFirestore(user));
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    } else {
      return left(Failure(errrorMessage: 'No internet connection'));
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
  Future<Either<Failure, void>> register({
    required String email,
    required String password,
  }) async {
    try {
      await auth.register(email, password);

      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(errrorMessage: error.code));
    }
  }

  @override
  Future<Either<Failure, List<Load>>> fetchLoads() async {
    if (await internetChecker.isConnected()) {
      try {
        List<Map<String, dynamic>> list = await firestore.fetchLoads();
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
  Future<Either<Failure, bool>> isFirstTime() async {
    if (await internetChecker.isConnected()) {
      bool f = await firestore.isFirstTime(await auth.getCurrentUserId());
      return right(f);
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(
      {required String email}) async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        return right(null);
      } on FirebaseAuthException catch (e) {
        return left(Failure(errrorMessage: e.code));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLoads(
      {required List<String> loads}) async {
    if (await internetChecker.isConnected()) {
      try {
        await firestore.deleteLoad(loads);
        return right(null);
      } on FirebaseAuthException catch (e) {
        return left(Failure(errrorMessage: e.code));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> fetchArticles() async {
    if (await internetChecker.isConnected()) {
      try {
        List<Map<String, dynamic>> list = await firestore.fetchArticles();
        List<Article> listz = _toArticle(list);

        return (right(listz));
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    }
    return left(Failure(errrorMessage: 'There is no internet connection'));
  }

  List<Article> _toArticle(List<Map<String, dynamic>> listmaps) {
    return listmaps.map((e) {
      return Article.fromFirestore(e);
    }).toList();
  }
}
