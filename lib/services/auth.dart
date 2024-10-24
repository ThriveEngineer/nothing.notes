import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nothing_note/components/login_or_register.dart';
import 'package:nothing_note/components/my_navbar.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        // user is logged in
        if (snapshot.hasData) {
          return MyNavbar();
        }

        // user is not logged in
        else {
          return LoginOrRegister();
        }
      }),
    );
  }
}