import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final String? username, phoneNumber, email, uid, address;
  const UserDetailScreen({
    Key? key,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.uid,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Supplier'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Username:'),
                    Text(username!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('email:'),
                    Text(email!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nomor Telepon:'),
                    Text(phoneNumber!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alamat:'),
                    Text(address!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ID Pengguna:'),
                    Text(uid!),
                  ],
                ),
              ],
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
        ),
      ),
    );
  }
}
