import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Timestamp date;
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.date,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 270),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Text(message,
              style: TextStyle(fontSize: 15, color: Colors.white)),
        ),
        //time
      ],
    );
  }
}
