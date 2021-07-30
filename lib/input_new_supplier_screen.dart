import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';

class InputNewSupplierScreen extends StatefulWidget {
  const InputNewSupplierScreen({Key? key}) : super(key: key);

  @override
  _InputNewSupplierScreenState createState() => _InputNewSupplierScreenState();
}

class _InputNewSupplierScreenState extends State<InputNewSupplierScreen> {
  final GlobalKey<FormState> _inputNewSupplierGlobalKey =
      GlobalKey<FormState>();
  String? _personName, _companyName, _phoneNumber, _companyAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Supplier Baru'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Form(
            key: _inputNewSupplierGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      _personName = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Nama Supplier',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi Nama Supplier';
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      _companyName = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Nama Perusahaan',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi Nama Perusahaan';
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
                      _phoneNumber = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Nomor Telepon',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi Nomor Telepon';
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      _companyAddress = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Alamat Perusahaan',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Mohon isi Alamat Perusahaan';
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
                          if (_inputNewSupplierGlobalKey.currentState!
                              .validate()) {
                            _inputNewSupplierGlobalKey.currentState!.save();
                            try {
                              await appState.addNewSupplier(
                                  personName: _personName,
                                  companyName: _companyName,
                                  phoneNumber: _phoneNumber,
                                  companyAddress: _companyAddress);
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
