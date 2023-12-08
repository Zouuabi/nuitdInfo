import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/load.dart';
import '../../models/user.dart';

class CloudFiresore {
  final _firestore = FirebaseFirestore.instance;
  String collectionrRef = 'users';
  String documentRef = '';

  Future<bool> isFirstTime(String uid) async {
    // Check if the user exists in Firestore by their UID
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return false; // User is registered in Firestore
    }

    return true; // User is not registered in Firestore
  }

  Future<List<Load>> fetchMyPosts({required String brokerUid}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('loads')
        .where('brokerUid', isEqualTo: brokerUid)
        .get();

    return querySnapshot.docs.map((load) {
      return Load.fromfirestore(load.data());
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchArticles() async {
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

  Future<List<Map<String, dynamic>>> fetchLoads() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('articles').get();

    List<Map<String, dynamic>> loadsList =
        querySnapshot.docs.map((documentSnapshot) {
      return documentSnapshot.data();
    }).toList();

    return loadsList;
  }

  Future<void> deleteLoad(List<String> loads) async {
    for (String loadRef in loads) {
      await _firestore.collection('loads').doc(loadRef).delete();
    }
  }
}
