import 'package:flutter/material.dart';

class SupplierDetailScreen extends StatelessWidget {
  final String? personName, companyName, phoneNumber, companyAddress;
  final int createdAt, updatedAt;
  const SupplierDetailScreen({
    Key? key,
    required this.personName,
    required this.companyName,
    required this.phoneNumber,
    required this.companyAddress,
    required this.createdAt,
    required this.updatedAt,
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
                    Text('Nama Supplier:'),
                    Text(personName!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nama Perusahaan:'),
                    Text(companyName!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nomor Supplier:'),
                    Text(phoneNumber!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alamat Perusahaan:'),
                    Text(companyAddress!),
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
