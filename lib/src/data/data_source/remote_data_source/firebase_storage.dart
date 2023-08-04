import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStr {
  final firebaseStorage = FirebaseStorage.instance;

  Future<String> storeImage(
      {required String child,
      required String uid,
      required Uint8List image}) async {
    print('storeimage run ');
    Reference ref = firebaseStorage.ref().child(child).child(uid);
    UploadTask task = ref.putData(image);
    var snapshot = await task;
    print('task compleete');
    return snapshot.ref.getDownloadURL();
  }
}
