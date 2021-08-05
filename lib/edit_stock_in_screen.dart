import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class EditStockInScreen extends StatefulWidget {
  final String name, stockCode, documentID, supplierName;
  final int quantity, outflows, price;

  const EditStockInScreen(
      {Key? key,
      required this.name,
      required this.stockCode,
      required this.documentID,
      required this.supplierName,
      required this.outflows,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  _EditStockInScreenState createState() => _EditStockInScreenState();
}

class _EditStockInScreenState extends State<EditStockInScreen> {
  Supplier? selectedSupplier;

  final GlobalKey<FormState> _editStockInGlobalKey = GlobalKey<FormState>();
  String? _name, _stockCode, _personName;
  int? _outflows, _quantity = 0, _price = 0;
  @override
  void initState() {
    super.initState();
    _personName = widget.supplierName;
    _name = widget.name;
    _stockCode = widget.stockCode;
    _quantity = widget.quantity;
    _outflows = widget.outflows;
    _price = widget.price;
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
        title: Text('Edit Stok Masuk'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Form(
            key: _editStockInGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  initialValue: _name,
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
                  initialValue: _stockCode,
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
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      hint: Text('Pilih Distributor'),
                      isExpanded: true,
                      value: _personName,
                      items: generateSupplierItem(appState.supplierList),
                      onChanged: (item) {
                        setState(() {
                          _personName = item;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _quantity.toString(),
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
                  initialValue: _price.toString(),
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
                          if (_editStockInGlobalKey.currentState!.validate()) {
                            _editStockInGlobalKey.currentState!.save();
                            try {
                              await appState.editStockInFirestore(
                                documentID: widget.documentID,
                                supplierName: _personName ?? 'tidak ada',
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
