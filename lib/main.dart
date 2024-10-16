import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nothing_note/irno/firebase_options.dart';
import 'package:nothing_note/home_page.dart';
import 'package:nothing_note/login_page.dart';
import 'package:nothing_note/services/auth.dart';
import 'package:nothing_note/components/login_or_register.dart';
import 'package:nothing_note/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}