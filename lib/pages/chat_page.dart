import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  const ChatPage({super.key, required this.recieverEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chat"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Text("Reciever Email: $recieverEmail"),
      ),
    );
  }
}
