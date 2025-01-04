import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of AuthService
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //method to sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //method to sign up

  //method to sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //errors
}
