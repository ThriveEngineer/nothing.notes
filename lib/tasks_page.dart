import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

// logout
void logout() {
  FirebaseAuth.instance.signOut();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // AppBar
      appBar: AppBar(
        title: const Text(
            "Tasks", 
            style: TextStyle(
              fontSize: 40, 
              fontWeight: FontWeight.w500),
              ),

            actions: [

              // logout button
              IconButton(onPressed: logout, icon: SvgPicture.asset(
                          'lib/icons/logout_icon.svg',
                          width: 40,
                          height: 40,
                          color: Colors.white,
                          )),

            ],
      ),
      
      body: Column(

      ),
    );
  }
}