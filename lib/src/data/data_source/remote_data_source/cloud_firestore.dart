import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doft/src/data/models/load.dart';

import '../../models/user.dart';

class CloudFiresore {
  final _firestore = FirebaseFirestore.instance;
  String collectionrRef = 'users';
  String documentRef = '';

  Future<List<Load>> fetchMyLoads({required String brokerUid}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('loads')
        .where('brokerUid', isEqualTo: brokerUid)
        .get();

    return querySnapshot.docs.map((load) {
      return Load.fromfirestore(load.data());
    }).toList();
  }

  Future<void> addToFavorites(
      {required String loadRef, required String uid}) async {
    await _firestore.collection('users').doc(uid).update({
      'favoriteLoads': FieldValue.arrayUnion([loadRef]),
    });
  }

  Future<void> removeFromFavorites(
      {required String loadRef, required String uid}) async {
    await _firestore.collection('users').doc(uid).update({
      'favoriteLoads': FieldValue.arrayRemove([loadRef]),
    });
  }

  Future<List<Load>> readFavoriteLoads(MyUser user) async {
    List<dynamic> favoriteLoadsRef = user.favoriteLoads;
    List<Load> favoriteLoads = [];
    for (String loadRef in favoriteLoadsRef) {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection('loads').doc(loadRef).get();
      if (docSnapshot.exists) {
        favoriteLoads.add(Load.fromfirestore(docSnapshot.data()!));
      } else {
        removeFromFavorites(loadRef: loadRef, uid: user.id);
        throw (Exception('load deleted'));
      }
    }
    return favoriteLoads;
  }

  Future<Map<String, dynamic>> getCurrentUserInformation(String uid) async {
    Map<String, dynamic>? user = await _firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => value.data());
    return user!;
  }

  Future<void> addNewUserInformations(
      {required String uid,
      required String imageLink,
      required String username,
      required String email,
      required String birdhdate,
      required String tel,
      required List<String> favoriteLoads}) async {
    Map<String, dynamic> user = {
      'uid': uid,
      'image': imageLink,
      'email': email,
      'tel': tel,
      'username': username,
      'birthdate': birdhdate,
      'favoriteLoads': []
    };
    await _firestore.collection(collectionrRef).doc(uid).set(user);
  }

  Future<void> postLoad(Map<String, dynamic> load, String brokerUid) async {
    var refdoc = _firestore.collection('loads').doc();
    load['loadRef'] = refdoc.id;
    load['brokerUid'] = brokerUid;
    await refdoc.set(load);
  }

  Future<List<Map<String, dynamic>>> readLoads() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('loads')
        .orderBy(descending: true, 'loadDate')
        .get();

    List<Map<String, dynamic>> loadsList =
        querySnapshot.docs.map((documentSnapshot) {
      return documentSnapshot.data();
    }).toList();

    return loadsList;
  }
}
