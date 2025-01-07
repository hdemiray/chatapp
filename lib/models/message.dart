import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.timestamp,
  });

  //convert to map
  Map<String, dynamic> toMap() {
    return {
      "senderID": senderID,
      "senderEmail": senderEmail,
      "recieverId": recieverId,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
