import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';

class EditStockAvailableScreen extends StatefulWidget {
  final String name, stockCode, documentID;
  final int quantity, expectedIncome, price;
  const EditStockAvailableScreen(
      {Key? key,
      required this.documentID,
      required this.name,
      required this.stockCode,
      required this.expectedIncome,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  _EditStockAvailableScreenState createState() =>
      _EditStockAvailableScreenState();
}

class _EditStockAvailableScreenState extends State<EditStockAvailableScreen> {
  final GlobalKey<FormState> _editStockGlobalKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _stockCodeController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  int? _quantity = 0, _price = 0, _expectedIncome = 0;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _stockCodeController.text = widget.stockCode;
    _quantityController.text = widget.quantity.toString();
    _priceController.text = widget.price.toString();
    _expectedIncome = widget.expectedIncome;
    _quantity = int.parse(_quantityController.text);
    _price = int.parse(_priceController.text);
    _quantityController.addListener(() {
      setState(() {
        _quantity = int.parse(_quantityController.text);
      });
      _priceController.addListener(() {
        setState(() {
          _price = int.parse(_priceController.text);
        });
      });
    });
  }

  @override
  void dispose() {
    _priceController.removeListener(() {});
    _stockCodeController.removeListener(() {});
    _nameController.dispose();
    _stockCodeController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Stok Yang Ada'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Form(
            key: _editStockGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
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
                  controller: _stockCodeController,
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
                  controller: _quantityController,
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
                  controller: _priceController,
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
                    Text('Ekspektasi Keuntungan :'),
                    Text(
                      NumberFormat.currency(name: 'IDR ').format(
                        (int.parse(_quantityController.text) *
                            int.parse(_priceController.text)),
                      ),
                    ),
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
                          if (_editStockGlobalKey.currentState!.validate()) {
                            String? _name = _nameController.text;
                            String? _stockCode = _stockCodeController.text;
                            _expectedIncome = _quantity! * _price!;
                            try {
                              await appState.editStockAvailableFirestore(
                                  name: _name,
                                  stockCode: _stockCode,
                                  expectedIncome: _expectedIncome,
                                  quantity: _quantity,
                                  price: _price,
                                  documentID: widget.documentID);
                              Navigator.of(context).pop();
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
