import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //AuthService & firestore instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //method to sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user infor if it's not already saved
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //method to sign up

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //add user to firestore
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //method to sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
  //errors
}
