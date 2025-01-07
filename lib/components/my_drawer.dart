import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/pages/settings_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyDrawer());

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //method to sign out
  void logOut() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //logo
            DrawerHeader(
              child: Icon(
                Icons.message,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            //home list tile
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: ListTile(
                leading: Icon(Icons.home,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text("H O M E"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            //settings list tile
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: ListTile(
                leading: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text("S E T T I N G S"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Settings();
                  }));
                },
              ),
            ),
          ]),
          //logout list tile
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(Icons.logout,
                  color: Theme.of(context).colorScheme.primary),
              title: const Text("L O G O U T"),
              onTap: logOut,
            ),
          ),
        ],
      ),
    );
  }
}
