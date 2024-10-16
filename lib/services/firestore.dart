import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference notes =
  FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String userId,String note) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await notes.doc(userId).collection('notes').add({
        "note": note,
        "timestamp": Timestamp.now(),
        "userId": userId,
      });
    }
  }
Stream<QuerySnapshot> getNotesStream() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    final notesStream = notes.doc(userId).collection('notes').orderBy("timestamp", descending: true).snapshots();
    return notesStream;
  } else {
    return Stream.empty(); // Return an empty stream
  }
}

  // UPDATE: update notes given a doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      "note": newNote,
      "timestamp": Timestamp.now(),
    });
  }

  // DELETE: delete notes given a doc id
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}