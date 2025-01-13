import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/themes/theme_provide.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Bildirimleri başlat
  await NotificationService().initNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).theme,
      home: AuthGate(),
    );
  }
}
