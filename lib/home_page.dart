import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nothing_note/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser?.uid;

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  // open a Textbox to add a note
  void openNoteBox({String? docID}) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      content: TextField(
        controller: textController,
      ), 
      backgroundColor: Theme.of(context).colorScheme.secondary,
      actions: [

        // button to save
        ElevatedButton(
          onPressed: () {

            // add a new note
            if (docID == null) {
              final userId = FirebaseAuth.instance.currentUser?.uid;
              if (userId != null) {
                firestoreService.addNote(userId, textController.text);
              }
            }

            // clear the text controller
            textController.clear();

            // close the box
            Navigator.pop(context);
          }, 
          child: Text("Add", style: TextStyle(fontFamily: "Nothing", color: Theme.of(context).colorScheme.inversePrimary,),),
          ),
      ],
      ));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes", 
          style: TextStyle(
            fontFamily: "Nothing", 
            fontWeight: FontWeight.w500, 
            fontSize: 40),
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

           // add a new note
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: openNoteBox, 
        child: SvgPicture.asset(
                  'lib/icons/plus_icon.svg',
                  width: 35,
                  height: 35,
                  color: Colors.white,
                  ),
        ),


        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNotesStream(),
          builder: (context, snapshot) {

            // if we have data, get all the docs
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;

              // display as a list
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  
                // get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // get note from each doc
                Map<String, dynamic> data =
                     document.data() as Map<String, dynamic>;
                String noteText = data ['note'];

                // display as a list tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      // delete button
                      IconButton(onPressed: () => firestoreService.deleteNote(docID, userId!), 
                      icon: SvgPicture.asset(
                        'lib/icons/delete_icon.svg',
                        width: 40,
                        height: 40,
                        color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),

                );
              },
             );
            }

            else {
              return const Text("No notes...");
            }
          }
        )
    );
  }
}