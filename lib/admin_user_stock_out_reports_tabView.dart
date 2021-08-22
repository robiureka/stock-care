import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/admin_user_stock_in_reports_listView.dart';
import 'package:test_aplikasi_tugas_akhir/admin_user_stock_out_reports_listView.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_invoice_api.dart';

class AdminUserStockOutReportsTabView extends StatefulWidget {
  const AdminUserStockOutReportsTabView({Key? key}) : super(key: key);

  @override
  _AdminUserStockOutReportsTabViewState createState() =>
      _AdminUserStockOutReportsTabViewState();
}

class _AdminUserStockOutReportsTabViewState
    extends State<AdminUserStockOutReportsTabView> {
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
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 220,
                    child: AdminUserStockOutReportsListView(
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
