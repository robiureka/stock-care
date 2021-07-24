import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');

Future<bool> getUserByRole(String uid) async {
  DocumentSnapshot doc = await usersRef.doc(uid).get();
  return doc['isOwner'];
}

