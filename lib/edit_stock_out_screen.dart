import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_model.dart';

class EditStockOutScreen extends StatefulWidget {
  final Stock stock;
  final String name, documentID;
  final int quantity, incomingFunds, price;
  const EditStockOutScreen(
      {Key? key,
      required this.documentID,
      required this.name,
      required this.incomingFunds,
      required this.price,
      required this.stock,
      required this.quantity})
      : super(key: key);

  @override
  _EditStockOutScreenState createState() => _EditStockOutScreenState();
}

class _EditStockOutScreenState extends State<EditStockOutScreen> {
  // final provider = Provider.of<ApplicationState>(context);
  Stock? _selectedStock;
  TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _inputNewStockOutKey = GlobalKey<FormState>();
  String? _name, _stockCode;
  int? _incomingFunds, _quantity = 0, _price = 0;
  @override
  void initState() {
    super.initState();
    // final provider = Provider.of<ApplicationState>(context);
    _nameController.text = widget.name;
    _stockCode = widget.stock.stockCode;
    _price = widget.price;
    _name = _nameController.text;
    _quantity = widget.quantity;
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  List<DropdownMenuItem<Stock>> generateStockItem(List<Stock> stocks) {
    List<DropdownMenuItem<Stock>> items = [];
    for (var item in stocks) {
      items.add(DropdownMenuItem(
        child: Text(item.stockCode!),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stok Keluar'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Form(
            key: _inputNewStockOutKey,
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
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<Stock>(
                      hint: Text('Pilih Kode Stok'),
                      isExpanded: true,
                      value: _selectedStock,
                      items: generateStockItem(appState.stockToStockOutList),
                      onChanged: (item) {
                        setState(() {
                          _selectedStock = item;
                          _stockCode = item!.stockCode;
                          _nameController.text = item.name!;
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
                    Text('Dana Masuk :'),
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
                          _incomingFunds = _quantity! * _price!;
                          if (_inputNewStockOutKey.currentState!.validate()) {
                            _inputNewStockOutKey.currentState!.save();
                            try {
                              await appState.editStockOutFirestore(
                                  name: _name,
                                  stockCode: _stockCode,
                                  incomingFunds: _incomingFunds,
                                  quantity: _quantity,
                                  price: _price,
                                  documentID: widget.documentID);
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

  @override
  void dispose() {
    _nameController.removeListener(() {});
    _nameController.dispose();
    super.dispose();
  }
}
