import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/edit_stock_available_screen.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_detail_screen.dart';
import 'package:test_aplikasi_tugas_akhir/stock_model.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_detail_screen.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class AdminSupplierListView extends StatefulWidget {
  final String filter;
  const AdminSupplierListView({Key? key, required this.filter})
      : super(key: key);

  @override
  _AdminSupplierListViewState createState() => _AdminSupplierListViewState();
}

class _AdminSupplierListViewState extends State<AdminSupplierListView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Supplier> _supplierList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('supplier')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          _supplierList = snapshot.data!.docs.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return Supplier(
                personName: data['nama supplier'],
                companyName: data['nama perusahaan'],
                companyAddress: data['alamat perusahaan'],
                phoneNumber: data['nomor supplier'],
                uid: data['uid'],
                createdAt: data['created_at'],
                updatedAt: data['updated_at']);
          }).where((element) {
            final personNameLower = element.personName!.toLowerCase();
            final filterLower = widget.filter.toLowerCase();
            final companyNameLower = element.companyName!.toLowerCase();
            return personNameLower.contains(filterLower) ||
                companyNameLower.contains(filterLower);
          }).toList();
          _supplierList.sort((b, a) => a.createdAt!.compareTo(b.createdAt!));
          return (_supplierList.isEmpty)
              ? Center(
                  child: Text('Kosong'),
                )
              : ListView.builder(
                  itemCount: _supplierList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Supplier supplier = _supplierList[index];
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SupplierDetailScreen(
                                  personName: supplier.personName,
                                  companyName: supplier.companyName,
                                  phoneNumber: supplier.phoneNumber,
                                  companyAddress: supplier.companyAddress)));
                        },
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actions: [
                                // IconSlideAction(
                                //   color: Colors.green,
                                //   caption: 'Edit',
                                //   icon: Icons.edit,
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             EditStockAvailableScreen(
                                //           name: stock.name!,
                                //           stockCode: stock.stockCode!,
                                //           expectedIncome: stock.expectedIncome!,
                                //           price: stock.price!,
                                //           quantity: stock.quantity!,
                                //           documentID: document.reference.id,
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                IconSlideAction(
                                  color: Colors.red,
                                  caption: 'Delete',
                                  icon: Icons.delete,
                                  onTap: () async {
                                    await document.reference.delete();
                                    _supplierList.remove(document.reference.id);
                                  },
                                ),
                              ],
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(supplier.personName!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(supplier.companyName!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(supplier.companyAddress!.toString()),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text('Dimiliki Oleh: ${supplier.uid!}'),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
