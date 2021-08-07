import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/edit_stock_out_screen.dart';
import 'package:test_aplikasi_tugas_akhir/stock_model.dart';
import 'package:test_aplikasi_tugas_akhir/stock_out_detail_screen.dart';

class StockOutListView extends StatefulWidget {
  final String filter;
  const StockOutListView({ Key? key,required this.filter }) : super(key: key);

  @override
  _StockOutListViewState createState() => _StockOutListViewState();
}

class _StockOutListViewState extends State<StockOutListView> {
 FirebaseFirestore db = FirebaseFirestore.instance;
  List<Stock> _stockOutList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('stock-out')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          _stockOutList = snapshot.data!.docs.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return Stock.keluar(
                incomingFunds: data['dana masuk'],
                name: data['nama barang'],
                price: data['harga satuan'],
                quantity: data['kuantitas'],
                stockCode: data['kode barang'],
                createdAt: data['created_at'],
                updatedAt: data['updated_at']);
          }).where((element) {
            final stockCodeLower = element.stockCode!.toLowerCase();
            final filterLower = widget.filter.toLowerCase();
            final nameLower = element.name!.toLowerCase();
            return stockCodeLower.contains(filterLower) ||
                nameLower.contains(filterLower);
          }).toList();
          _stockOutList
              .sort((b, a) => a.createdAt!.compareTo(b.createdAt!));
          return (_stockOutList.isEmpty)
              ? Center(
                  child: Text('Kosong'),
                )
              : ListView.builder(
                  itemCount: _stockOutList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Stock stock = _stockOutList[index];
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StockOutDetailScreen(
                                    name: stock.name,
                                    stockCode: stock.stockCode,
                                    quantity: stock.quantity,
                                    price: stock.price,
                                    incomingFunds: stock.incomingFunds,
                                    createdAt: stock.createdAt,
                                    updatedAt: stock.updatedAt,
                                  )));
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
                                        builder: (context) =>
                                            EditStockOutScreen(
                                          name: stock.name!,
                                          stock: stock,
                                          incomingFunds: stock.incomingFunds!,
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
                                    _stockOutList
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
                                    Text(stock.name!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(stock.stockCode!),
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
                                          child: Text('Dana Masuk'),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: Text(NumberFormat.currency(
                                                  locale: 'in ',
                                                  decimalDigits: 0)
                                              .format(stock.incomingFunds)
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