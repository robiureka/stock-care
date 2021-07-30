import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_aplikasi_tugas_akhir/input_new_supplier_screen.dart';
import 'package:test_aplikasi_tugas_akhir/owner_drawer.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier'),
      ),
      drawer: OwnerDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InputNewSupplierScreen()));
        },
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection(
                    'users/${FirebaseAuth.instance.currentUser!.uid}/supplier-list')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              print(snapshot.data.toString());
              List<Supplier> _supplierList = [];
              _supplierList = snapshot.data!.docs.map((element) {
                Map<String, dynamic> data =
                    element.data() as Map<String, dynamic>;
                return Supplier(
                  personName: data['nama supplier'],
                  companyName: data['nama perusahaan'],
                  phoneNumber: data['nomor supplier'],
                  companyAddress: data['alamat perusahaan'],
                );
              }).toList();
              return (_supplierList.isEmpty)
                  ? Center(child: Text('Kosong'))
                  : ListView.builder(
                      itemCount: _supplierList.length,
                      itemBuilder: (context, index) {
                        Supplier supplier = _supplierList[index];
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 10.0),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Slidable(
                                actionPane: SlidableScrollActionPane(),
                                actions: [
                                  IconSlideAction(
                                    icon: Icons.edit,
                                    color: Colors.green,
                                    caption: 'edit',
                                    foregroundColor: Colors.white,
                                    onTap: () {},
                                    closeOnTap: true,
                                  ),
                                  IconSlideAction(
                                    icon: Icons.delete,
                                    color: Colors.red,
                                    caption: 'delete',
                                    foregroundColor: Colors.white,
                                    onTap: () {},
                                    closeOnTap: true,
                                  ),
                                ],
                                child: ListTile(
                                  title: Text(supplier.personName!),
                                  subtitle: Text(supplier.phoneNumber!),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
            }),
      ),
    );
  }
}
