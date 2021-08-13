import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/admin_stock_out_listView.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/invoice_model.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_api.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_invoice_api.dart';
import 'package:test_aplikasi_tugas_akhir/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class AdminStockOutTabView extends StatefulWidget {
  const AdminStockOutTabView({Key? key}) : super(key: key);

  @override
  _AdminStockOutTabViewState createState() => _AdminStockOutTabViewState();
}

class _AdminStockOutTabViewState extends State<AdminStockOutTabView> {
  final db = FirebaseFirestore.instance;
  String filter = '';
  int? invoiceNumber;
  PdfInvoiceApi pia = PdfInvoiceApi();
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
    return Consumer<ApplicationState>(
        builder: (context, appState, _) => SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                  
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          invoiceNumber = Random().nextInt(9999);
                          final date = DateTime.now();
                          final invoice = Invoice(
                            user: UserInApp(
                              username: appState.getCustomerName,
                              uid: appState.getUid,
                              email: appState.getEmail,
                            ),
                            info: InvoiceInfo(
                              date: date,
                              description:
                                  'Invoice stok keluar ini telah dibuat oleh Admin',
                              number:
                                  '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
                            ),
                            items: appState.adminStockOutToInvoiceItem,
                          );

                          final pdfFile =
                              await pia.generateStockOutInvoiceByAdmin(invoice, invoiceNumber!);
                          fs.Reference ref = fs.FirebaseStorage.instance
                              .ref()
                              .child('reports')
                              .child(pdfFile.path);
                          fs.UploadTask task = ref.putFile(pdfFile);
                          fs.TaskSnapshot snapshot =
                              await task.whenComplete(() {});
                          String downloadURL =
                              await snapshot.ref.getDownloadURL();
                          await db.collection('reports').add({
                            'isPaid': false,
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            'username':
                                FirebaseAuth.instance.currentUser!.displayName,
                            'download_url': downloadURL,
                            'invoice_number':
                                '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
                            'created_at': DateTime.now().millisecondsSinceEpoch,
                            'updated_at': DateTime.now().millisecondsSinceEpoch,
                            'category': 'stock-out',
                            'created_by': 'admin',
                          });
                          setState(() {});
                          PdfApi.openFile(pdfFile);
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: Text('Buat PDF')),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 220,
                    child: AdminStockOutListView(
                      filter: filter,
                    )),
              ]),
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
