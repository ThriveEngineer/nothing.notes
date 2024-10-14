import 'package:flutter/material.dart';
import 'package:nothing_note/components/my_button.dart';
import 'package:nothing_note/components/my_textfield.dart';
import 'package:nothing_note/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  final void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap
    });

  // login method
  void login () {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              // logo
              Center(child: Icon(Icons.lock_open_rounded, size: 72,)),

              const SizedBox(height: 25,),
          
              // app name
              Text("L O G I N", style: TextStyle(fontSize: 20),),

              const SizedBox(height: 50,),
          
              // email textfield
              MyTextfield(
                hintText: "Email", 
                controller: emailController, 
                obscureText: false
                ),

                const SizedBox(height: 10,),
          
              // password textfield
              MyTextfield(hintText: "Password", 
              controller: pwController,
              obscureText: true),

              const SizedBox(height: 10,),
          
              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?", 
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                ],
              ),

              const SizedBox(height: 25,),
          
              // sign in button
              MyButton(text: "Login", onTap: login),

              const SizedBox(height: 25,),

          
              // dont have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,),
                    ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      " Register Here!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}