import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/home.dart';
import 'package:test_aplikasi_tugas_akhir/home_supplier_screen.dart';
import 'package:test_aplikasi_tugas_akhir/login_screen.dart';

User? user = FirebaseAuth.instance.currentUser;
final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? isOwner =false;
  @override
  void initState() {
    getUserByRole(user?.uid ?? 'none');
    super.initState();
    
  }

  getUserByRole(String uid) async {
    DocumentSnapshot doc = await usersRef.doc('XOgJfg52HRXRC1NwAXZvkJ4ApSg2').get();
    print(doc['isOwner']);
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

// (user == null) ? LoginScreen() : (isOwner == false) ? SupplierHomeScreen() : HomeScreen();
