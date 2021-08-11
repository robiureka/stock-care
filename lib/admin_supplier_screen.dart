import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/admin_supplier_listView.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/user_model.dart';
import 'package:test_aplikasi_tugas_akhir/admin_users_listView.dart';

class AdminSupplierScreen extends StatefulWidget {
  const AdminSupplierScreen({Key? key}) : super(key: key);

  @override
  _AdminSupplierScreenState createState() => _AdminSupplierScreenState();
}

class _AdminSupplierScreenState extends State<AdminSupplierScreen> {
  final db = FirebaseFirestore.instance;
  String filter = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
  }

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Suppliers'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    onChanged: (String? value) async {
                      debounce(() async {
                        setState(() {
                          this.filter = value!;
                          print(filter);
                        });
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0,),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              child: AdminSupplierListView(filter: filter,)),
        ]),
      ),
    );
  }
}
