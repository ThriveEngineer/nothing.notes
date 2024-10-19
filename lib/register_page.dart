import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nothing_note/components/helper_functions.dart';
import 'package:nothing_note/components/my_button.dart';
import 'package:nothing_note/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
    });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwConfirmController = TextEditingController();

    // register method
  void register () async {
    
    // show loading circle
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    )
   );

   // make sure pw matche
   if (pwController.text != pwConfirmController.text) {
    // pop loading circle
    Navigator.pop(context);

    // show error message to user
    displayMessageToUser("Passwords don't match!", context);

   } else {

    // creating user
   try {
    // create the user
    UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: pwController.text);
      
      Navigator.pop(context);
   } on FirebaseAuthException catch (e) {
    // pop loading cirlce
    Navigator.pop(context);

    // display error message
    displayMessageToUser(e.code, context);
    }
   }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 115),
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

              // password confirm textfield
              MyTextfield(hintText: "Confirm Password", 
              controller: pwConfirmController,
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
              MyButton(text: "Register", onTap: register),

              const SizedBox(height: 25,),

          
              // dont have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,),
                    ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here!",
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