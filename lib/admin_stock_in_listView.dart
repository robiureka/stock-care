import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/edit_stock_in_screen.dart';
import 'package:test_aplikasi_tugas_akhir/invoice_model.dart';
import 'package:test_aplikasi_tugas_akhir/stock_in_detail_screen.dart';
import 'package:test_aplikasi_tugas_akhir/stock_model.dart';

class AdminStockInListView extends StatefulWidget {
  final String filter;
  const AdminStockInListView({Key? key, required this.filter})
      : super(key: key);

  @override
  _AdminStockInListViewState createState() => _AdminStockInListViewState();
}

class _AdminStockInListViewState extends State<AdminStockInListView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Stock> _adminStockInList = [];
  List<InvoiceItem> _adminStockInInvoiceItemList = [];
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('stock-in')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          _adminStockInList = snapshot.data!.docs.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;

            return Stock.adminMasuk(
                uid: data['uid'],
                username: data['username'] ?? "Tidak Ada",
                outflows: data['dana keluar'],
                name: data['nama barang'],
                price: data['harga satuan'],
                quantity: data['kuantitas'],
                supplierName: data['nama supplier'],
                stockCode: data['kode barang'],
                createdAt: data['created_at'],
                updatedAt: data['updated_at'],
                email: data['email']);
          }).where((element) {
            final filterLower = widget.filter.toLowerCase();
            final stockCodeLower = element.stockCode!.toLowerCase();
            final nameLower = element.name!.toLowerCase();
            final supplierNameLower = element.supplierName!.toLowerCase();
            final usernameLower = element.username!.toLowerCase();
            final uidLower = element.uid!.toLowerCase();
            return stockCodeLower.contains(filterLower) ||
                nameLower.contains(filterLower) ||
                uidLower.contains(filterLower) ||
                usernameLower.contains(filterLower) ||
                supplierNameLower.contains(filterLower);
          }).toList();
          _adminStockInInvoiceItemList = _adminStockInList.map((e) {
            return InvoiceItem.masuk(
                name: e.name,
                stockCode: e.stockCode,
                quantity: e.quantity,
                outflows: e.outflows,
                supplierName: e.supplierName,
                price: e.price);
          }).toList();
          appState.setAdminStockInToInvoiceItem = _adminStockInInvoiceItemList;
          if (_adminStockInList.isNotEmpty) {
            appState.setCustomerName =
                _adminStockInList[0].username ?? 'tidak ada';
            appState.setUid = _adminStockInList[0].uid ?? 'tidak ada';
            appState.setEmail = _adminStockInList[0].email ?? "tidak Ada";
            appState.setSupplierName = _adminStockInList[0].supplierName ?? 'tidak ada';
          }
          _adminStockInList
              .sort((b, a) => a.createdAt!.compareTo(b.createdAt!));
          return (_adminStockInList.isEmpty)
              ? Center(
                  child: Text('Kosong'),
                )
              : ListView.builder(
                  itemCount: _adminStockInList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Stock stock = _adminStockInList[index];
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StockInDetailScreen(
                                      name: stock.name,
                                      stockCode: stock.stockCode,
                                      supplierName: stock.supplierName,
                                      quantity: stock.quantity,
                                      price: stock.price,
                                      outflows: stock.outflows,
                                      createdAt: stock.createdAt,
                                      updatedAt: stock.updatedAt)));
                        },
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actions: [
                                IconSlideAction(
                                  color: Colors.green,
                                  caption: 'Edit',
                                  icon: Icons.edit,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditStockInScreen(
                                          supplierName: stock.supplierName!,
                                          name: stock.name!,
                                          stockCode: stock.stockCode!,
                                          outflows: stock.outflows!,
                                          price: stock.price!,
                                          quantity: stock.quantity!,
                                          documentID: document.reference.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconSlideAction(
                                  color: Colors.red,
                                  caption: 'Delete',
                                  icon: Icons.delete,
                                  onTap: () async {
                                    await document.reference.delete();
                                    _adminStockInList
                                        .remove(document.reference.id);
                                  },
                                ),
                              ],
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("User ID: ${stock.uid!}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(stock.username!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(stock.name!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(stock.stockCode!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(stock.supplierName!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(stock.quantity!.toString()),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(NumberFormat.currency(
                                            locale: 'in', decimalDigits: 0)
                                        .format(stock.price!)
                                        .toString()),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 3,
                                          child: Text('Dana Keluar'),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: Text(NumberFormat.currency(
                                                  locale: 'in ',
                                                  decimalDigits: 0)
                                              .format(stock.outflows)
                                              .toString()),
                                        ),
                                      ],
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
