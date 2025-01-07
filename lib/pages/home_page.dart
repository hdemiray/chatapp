import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

//chat&auth instance
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        //loading
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        //return list view
        else {
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                recieverEmail: userData["email"],
              ),
            ),
          );
        },
      );
    }
    return const SizedBox();
  }
}
