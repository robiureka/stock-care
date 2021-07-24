import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import "package:intl/intl.dart";

class InputNewStockScreen extends StatefulWidget {
  const InputNewStockScreen({Key? key}) : super(key: key);

  @override
  _InputNewStockScreenState createState() => _InputNewStockScreenState();
}

class _InputNewStockScreenState extends State<InputNewStockScreen> {
  final GlobalKey<FormState> _inputNewStockGlobalKey = GlobalKey<FormState>();
  String? _name, _stockCode;
  int? _expectedIncome, _quantity = 0, _price = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Stok Baru'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Form(
            key: _inputNewStockGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Nama Barang',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi Nama Barang';
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      _stockCode = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Kode Barang',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi Kode Barang';
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    setState(() {
                      _quantity = int.parse(value!);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Kuantitas',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi Kuantitas';
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.parse(value!);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Harga Satuan',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi harga satuan';
                    }
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Ekspektasi Keuntungan :'),
                  Text(NumberFormat.currency(name: 'IDR ').format((_quantity! * _price!))),
                ],),
                SizedBox(
                  height: 25.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: Consumer<ApplicationState>(
                      builder: (context, appState, _) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade700,
                        ),
                        onPressed: () async {
                          _expectedIncome = _quantity! * _price!;
                          if (_inputNewStockGlobalKey.currentState!
                              .validate()) {
                            _inputNewStockGlobalKey.currentState!.save();
                            try {
                              await appState.addStockAvailableFirestore(
                                expectedIncome: _expectedIncome,
                                quantity: _quantity,
                                name: _name,
                                price: _price,
                                stockCode: _stockCode,
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              print(e.toString());
                            }
                          }
                        },
                        child: Text(
                          'CONFIRM',
                          style: TextStyle(letterSpacing: 2, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
