import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/invoice_model.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_api.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_invoice_api.dart' as pia;
import 'package:test_aplikasi_tugas_akhir/pdf_invoice_api.dart';
import 'package:test_aplikasi_tugas_akhir/stock_in_listView.dart';
import 'package:test_aplikasi_tugas_akhir/user_model.dart';
import 'package:path/path.dart';

class StockInTabView extends StatefulWidget {
  const StockInTabView({Key? key}) : super(key: key);

  @override
  _StockInTabViewState createState() => _StockInTabViewState();
}

class _StockInTabViewState extends State<StockInTabView> {
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
                          final date = DateTime.now();
                          final invoice = Invoice(
                            user: UserInApp(
                              username: FirebaseAuth
                                  .instance.currentUser!.displayName,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              email: FirebaseAuth.instance.currentUser!.email,
                            ),
                            info: InvoiceInfo(
                              date: date,
                              description:
                                  'Invoice ini telah dibuat oleh ${FirebaseAuth.instance.currentUser!.displayName}',
                              number:
                                  '${DateTime.now().year}-${pia.randomNumber}',
                            ),
                            items: appState.stockInToInvoiceItem,
                          );

                          final pdfFile =
                              await pia.PdfInvoiceApi.generateStockInInvoice(
                                  invoice);
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
                            'invoice number': '${DateTime.now().year}-${pia.randomNumber}'
                          });
                          PdfApi.openFile(pdfFile);
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: Text('Buat PDF')),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 260,
                    child: StockInListView(
                      filter: filter,
                    )),
              ]),
            ));
  }
}
