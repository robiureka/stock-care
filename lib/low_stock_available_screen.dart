import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/low_stock_available_listView.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_listView.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LowStockAvailableScreen extends StatefulWidget {
  const LowStockAvailableScreen({Key? key}) : super(key: key);

  @override
  _LowStockAvailableScreenState createState() =>
      _LowStockAvailableScreenState();
}

class _LowStockAvailableScreenState extends State<LowStockAvailableScreen> {
  final db = FirebaseFirestore.instance;
  String filter = '', phoneNumber='', message ='Saya ingin membuat permintaan barang dengan nama barang sebagai berikut:\n\n';
  Supplier? supplier;
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

  List<DropdownMenuItem<Supplier>> generateSupplierObjectItem(
      List<Supplier> suppliers) {
    List<DropdownMenuItem<Supplier>> items = [];
    for (var item in suppliers) {
      items.add(DropdownMenuItem(
        child: Text(item.personName!),
        value: item,
      ));
    }
    return items;
  }

  void launchWhatsapp({required String number, required String message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url)
        ? launch(url)
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Whatsapp tidak ada dalam perangkat anda')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stok Sedikit"),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: DropdownButton<Supplier>(
                hint: Text('Pilih Distributor'),
                isExpanded: true,
                value: supplier,
                items: generateSupplierObjectItem(appState.supplierObjectList),
                onChanged: (item) {
                  setState(() {
                    supplier = item;
                    phoneNumber = item!.phoneNumber!;
                  });
                },
              ),
            ),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                  onPressed: () {
                    print(supplier!.phoneNumber);
                    for (var item in appState.lowStockList) {
                      message += '${item.name}\n';
                    }
                    launchWhatsapp(number: phoneNumber, message: message);
                  }, child: Text('Buat Permintaan Barang')),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 220,
              child: LowStockAvailableListView(
                filter: filter,
              )),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
