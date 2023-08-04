import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<User?> register(String email, String password) async {
    var cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }
}
