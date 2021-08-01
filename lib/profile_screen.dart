import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? _username, _phoneNumber, _address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  _username = data['username'];
                  _phoneNumber = data['nomor telepon'];
                  _address = data['alamat'];
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Username:'),
                          Text(data['username']),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email:'),
                          Text(data['email']),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nomor Telepon:'),
                          Text(data['nomor telepon']),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Alamat:'),
                          Text(data['alamat']),
                        ],
                      ),
                    ],
                  );
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                                username: _username!,
                                address: _address!,
                                phoneNumber: _phoneNumber!)));
                  },
                  child: Text('PERBARUI'),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18.0, letterSpacing: 3.0),
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2.0),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('KEMBALI'),
                  style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18.0, letterSpacing: 3.0),
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2.0),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
