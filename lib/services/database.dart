import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference chatCollection =
  FirebaseFirestore.instance.collection('chat');

  final Query chatCollectionsSorted =
  FirebaseFirestore.instance.collection('chat').orderBy('date');

  Future addNewMessage(String sender, String message) async {
    return await chatCollection.add(
      {
        'sender': sender,
        'message': message,
        'date': DateTime.now(),
      },
    );
  }

  Future getCurrentUser() async {
    try {
      final user =  _auth.currentUser;
      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
  }
}
