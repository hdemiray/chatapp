import 'package:chatapp/themes/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark mode button text
            Text(
              "Koyu mod",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            //switch toggle button
            Switch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              activeColor: Colors.green,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
