import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/invoice_model.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_api.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_invoice_api.dart';
import 'package:test_aplikasi_tugas_akhir/stock_in_listView.dart';
import 'package:test_aplikasi_tugas_akhir/user_model.dart';
import 'package:test_aplikasi_tugas_akhir/database.dart' as dbService;
class StockInTabView extends StatefulWidget {
  const StockInTabView({Key? key}) : super(key: key);

  @override
  _StockInTabViewState createState() => _StockInTabViewState();
}

class _StockInTabViewState extends State<StockInTabView> {
  final db = FirebaseFirestore.instance;
  String filter = '';
  int? invoiceNumber;
  Timer? debouncer;
  PdfInvoiceApi pia = PdfInvoiceApi();
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
                                  '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
                            ),
                            items: appState.stockInToInvoiceItem,
                          );

                          final pdfFile =
                              await pia.generateStockInInvoice(invoice, invoiceNumber!);
                          await dbService.saveReportStockInByUser(pdfFile, invoiceNumber!);
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
                    height: MediaQuery.of(context).size.height - 260,
                    child: StockInListView(
                      filter: filter,
                    )),
              ]),
            ));
  }
}
