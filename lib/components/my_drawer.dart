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
                Icons.heart_broken,
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
                title: Text(
                  "H O M E",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            //settings list tile
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  "S E T T I N G S",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
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
              title: Text("L O G O U T",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
              onTap: logOut,
            ),
          ),
        ],
      ),
    );
  }
}
