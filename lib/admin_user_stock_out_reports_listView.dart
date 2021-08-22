import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/admin_user_stock_in_report_detail_screen.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/report_model.dart';
import 'package:test_aplikasi_tugas_akhir/stock_in_report_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUserStockOutReportsListView extends StatefulWidget {
  final String filter;
  const AdminUserStockOutReportsListView({Key? key, required this.filter})
      : super(key: key);

  @override
  _AdminUserStockOutReportsListViewState createState() =>
      _AdminUserStockOutReportsListViewState();
}

class _AdminUserStockOutReportsListViewState
    extends State<AdminUserStockOutReportsListView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Report> _userStockInReportList = [];

  void openPDFFile(String url) async {
    await canLaunch(url) ? launch(url) : print("Tidak Bisa Membuka File");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) =>
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db
            .collection('reports')
            .where('created_by', isEqualTo: "user")
            .where('category', isEqualTo: 'stock-out')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          _userStockInReportList = snapshot.data!.docs.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return Report.stockOut(
                username: data['username'] ?? 'admin',
                uid: data['uid'],
                downloadURL: data['download_url'],
                invoiceNumber: data['invoice_number'],
                createdBy: data['created_by'] ?? "User",
                createdAt: data['created_at']);
          }).where((element) {
            final usernameLower = element.username!.toLowerCase();
            final filterLower = widget.filter.toLowerCase();
            final uidLower = element.uid!.toLowerCase();
            final invoiceNumberLower = element.invoiceNumber!.toLowerCase();
            return usernameLower.contains(filterLower) ||
                invoiceNumberLower.contains(filterLower) ||
                uidLower.contains(filterLower);
          }).toList();
          return (_userStockInReportList.isEmpty)
              ? Center(
                  child: Text('Kosong'),
                )
              : ListView.builder(
                  itemCount: _userStockInReportList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Report report = _userStockInReportList[index];
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () async {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => StockAvailableDetailScreen(
                          //           name: stock.name,
                          //           stockCode: stock.stockCode,
                          //           quantity: stock.quantity,
                          //           price: stock.price,
                          //           expectedIncome: stock.expectedIncome,
                          //           createdAt: stock.createdAt,
                          //           updatedAt: stock.updatedAt,
                          //         )));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             AdminUserStockInReportDetailScreen(
                          //               downloadURL: report.downloadURL!,
                          //                 buktiTransferURL:
                          //                     report.buktiTransferURL!,
                          //                 isPaid: report.isPaid!,
                          //                 hasBuktiTransfer:
                          //                     report.hasBuktiTransfer!,
                          //                 isSent: report.isSent!,
                          //                 invoiceNumber: report.invoiceNumber!,
                          //                 documentID: document.reference.id)));
                          openPDFFile(report.downloadURL!);
                        },
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actions: [
                                IconSlideAction(
                                  color: Colors.red,
                                  caption: 'Delete',
                                  icon: Icons.delete,
                                  onTap: () async {
                                    await document.reference.delete();
                                    _userStockInReportList
                                        .remove(document.reference.id);
                                  },
                                ),
                              ],
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "UserID : ${report.uid ?? "Tidak Ada"}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(report.username ?? "tidak ada"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(report.invoiceNumber ?? "tidak ada"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text("Dibuat Oleh: ${(report.createdBy!)}"),
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
