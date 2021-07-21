import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_model.dart';

class InputNewStockDialog extends StatefulWidget {
  const InputNewStockDialog({Key? key}) : super(key: key);

  @override
  _InputNewStockDialogState createState() => _InputNewStockDialogState();
}

class _InputNewStockDialogState extends State<InputNewStockDialog> {
  final GlobalKey<FormState> _inputNewStockGlobalKey = GlobalKey<FormState>();
  String? _name, _stockCode;
  int? _expectedIncome, _quantity;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                onChanged: (String? value) {
                  setState(() {
                    _expectedIncome = int.parse(value!);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Untung yang Diharapkan',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (String? value) {
                  if (value == '' || value!.isEmpty) {
                    return 'Mohon isi Untung yang Diharapkan';
                  }
                },
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
                        if (_inputNewStockGlobalKey.currentState!.validate()) {
                          _inputNewStockGlobalKey.currentState!.save();
                          appState.addStockAvailable(
                            expectedIncome: _expectedIncome,
                            quantity: _quantity,
                            name: _name,
                            stockCode: _stockCode,
                          );
                          Navigator.pop(context);
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
    );
  }
}
