import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Colors.green.shade400
            : const Color.fromARGB(255, 155, 154, 154),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 10),
      child: Text(message,
          style: TextStyle(color: const Color.fromARGB(199, 255, 255, 255))),
    );
  }
}
