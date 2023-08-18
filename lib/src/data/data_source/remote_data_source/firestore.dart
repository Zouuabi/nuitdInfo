import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Timestamp a = Timestamp.fromDate(DateTime.now());
}
