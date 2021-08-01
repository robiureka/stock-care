import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class InputNewStockInScreen extends StatefulWidget {
  const InputNewStockInScreen({Key? key}) : super(key: key);

  @override
  _InputNewStockInScreenState createState() => _InputNewStockInScreenState();
}

class _InputNewStockInScreenState extends State<InputNewStockInScreen> {
  Supplier? selectedSupplier;

  final GlobalKey<FormState> _inputNewStockInGlobalKey = GlobalKey<FormState>();
  String? _name, _stockCode, supplierName;
  int? _outflows, _quantity = 0, _price = 0;
  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem<String>> generateSupplierItem(List<String> suppliers) {
    List<DropdownMenuItem<String>> items = [];
    for (var item in suppliers) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Stok Masuk Baru'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Form(
            key: _inputNewStockInGlobalKey,
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
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => Container(
                    margin: EdgeInsets.symmetric(horizontal:10.0),
                    child: DropdownButton<String>(
                    
                      hint: Text('Pilih Distributor'),
                      isExpanded: true,
                      value: supplierName,
                      items: generateSupplierItem(appState.supplierList),
                      onChanged: (item){
                        setState(() {
                          supplierName = item;
                        });
                      },
                    ),
                  ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dana Keluar :'),
                    Text(NumberFormat.currency(name: 'IDR ')
                        .format((_quantity! * _price!))),
                  ],
                ),
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
                          _outflows = _quantity! * _price!;
                          if (_inputNewStockInGlobalKey.currentState!
                              .validate()) {
                            _inputNewStockInGlobalKey.currentState!.save();
                            try {
                              await appState.addStockInFirestore(
                                supplierName: supplierName ?? 'tidak ada',
                                outflows: _outflows,
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
