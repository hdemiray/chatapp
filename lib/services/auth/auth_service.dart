import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/services/notification_service.dart';

class AuthService {
  //AuthService & firestore instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //method to sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      print("👤 AUTH SERVICE: Giriş yapılıyor...");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("👤 AUTH SERVICE: Giriş başarılı! Token kaydediliyor...");
      await NotificationService().saveUserToken(userCredential.user!.uid);

      //save user info if it's not already saved
      await _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        },
        SetOptions(merge: true),
      );
      print("👤 AUTH SERVICE: Kullanıcı bilgileri güncellendi!");

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("❌ AUTH SERVICE HATASI: ${e.message}");
      throw Exception(e.code);
    }
  }

  //method to sign up
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password) async {
    try {
      print("Kayıt yapılıyor...");
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Yeni kullanıcı kaydı başarılı, token kaydediliyor...");
      await NotificationService().saveUserToken(userCredential.user!.uid);

      //add user to firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        },
        SetOptions(merge: true),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Kayıt hatası: ${e.message}");
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
