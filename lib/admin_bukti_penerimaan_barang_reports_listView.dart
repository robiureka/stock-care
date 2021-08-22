import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';

import 'package:test_aplikasi_tugas_akhir/report_model.dart';

import 'package:url_launcher/url_launcher.dart';

class AdminBuktiPenerimaanBarangReportsListView extends StatefulWidget {
  final String filter;
  const AdminBuktiPenerimaanBarangReportsListView({Key? key, required this.filter})
      : super(key: key);

  @override
  _AdminBuktiPenerimaanBarangReportsListViewState createState() =>
      _AdminBuktiPenerimaanBarangReportsListViewState();
}

class _AdminBuktiPenerimaanBarangReportsListViewState
    extends State<AdminBuktiPenerimaanBarangReportsListView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Report> _adminBuktiPenerimaanBarangReportsList = [];

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
            .where('created_by', isEqualTo: 'admin')
            .where('category', isEqualTo: 'bukti-penerimaan-barang')
            // .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          _adminBuktiPenerimaanBarangReportsList = snapshot.data!.docs.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return Report.buktiPenerimaanBarang(
                username: data['username'] ?? "admin",
                downloadURL: data['download_url'],
                invoiceNumber: data['invoice_number'],
                createdBy: data['created_by'] ??  "Pengguna",
                isSigned: data['isSigned'],
                );
          }).where((element) {
            final usernameLower = element.username!.toLowerCase();
            final filterLower = widget.filter.toLowerCase();
            final invoiceNumberLower = element.invoiceNumber!.toLowerCase();
            return usernameLower.contains(filterLower) ||
                invoiceNumberLower.contains(filterLower);
          }).toList();
          return (_adminBuktiPenerimaanBarangReportsList.isEmpty)
              ? Center(
                  child: Text('Kosong'),
                )
              : ListView.builder(
                  itemCount: _adminBuktiPenerimaanBarangReportsList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Report report = _adminBuktiPenerimaanBarangReportsList[index];
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () async {
                          openPDFFile(report.downloadURL!);
                        },
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actions: [
                                IconSlideAction(
                                  color: Colors.green,
                                  caption: 'Konfirmasi\nTanda Tangan',
                                  icon: Icons.file_copy,
                                  onTap: () async {
                                    db.collection('reports').doc(document.reference.id).update({
                                      'isSigned': true,
                                    });
                                  },
                                ),
                                IconSlideAction(
                                  color: Colors.red,
                                  caption: 'Delete',
                                  icon: Icons.delete,
                                  onTap: () async {
                                    await document.reference.delete();
                                    _adminBuktiPenerimaanBarangReportsList
                                        .remove(document.reference.id);
                                  },
                                ),
                              ],
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(report.username ?? "tidak ada"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(report.invoiceNumber!),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text("Dibuat Oleh: ${(report.createdBy!)}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text("Tanda Tangan: ${(report.isSigned!) ? "Sudah" : "Belum"}"),
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
