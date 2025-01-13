import 'package:chatapp/models/message.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/services/notification_service.dart';

class ChatService {
  //instance of firestore & auth service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String recieverID, String message) async {
    //get current user info
    final String currentUserId = _authService.getCurrentUser()!.uid;
    final String currentUserEmail = _authService.getCurrentUser()!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      senderID: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: recieverID,
      message: message,
      timestamp: timestamp,
    );

    //construct chat room id for two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverID];
    ids.sort();

    String chatRoomId = ids.join("_");

    //add message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(
          newMessage.toMap(),
        );

    // Bildirim gönder
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        print("Bildirim gönderiliyor...");
        print("Alıcı ID: $recieverID");
        print("Gönderen: ${currentUser.email}");

        await NotificationService().sendNotification(
          receiverUserId: recieverID,
          message: message,
          senderName: currentUser.email ?? 'Kullanıcı',
          senderId: currentUser.uid,
        );

        print("Bildirim gönderildi!");
      } catch (e) {
        print("Bildirim gönderme hatası: $e");
      }
    }
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
