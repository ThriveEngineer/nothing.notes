import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nothing_note/home_page.dart';
import 'package:nothing_note/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        // user is logged in
        if (snapshot.hasData) {
          return HomePage();
        }

        // user is not logged in
        else {
          return LoginPage(onTap: () {},);
        }
      }),
    );
  }
}