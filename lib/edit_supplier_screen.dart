import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';

class EditSupplierScreen extends StatefulWidget {
  final String? personName,
      companyName,
      phoneNumber,
      companyAddress,
      documentID;
  const EditSupplierScreen(
      {Key? key,
      @required this.personName,
      @required this.companyName,
      @required this.phoneNumber,
      @required this.companyAddress,
      @required this.documentID})
      : super(key: key);

  @override
  _EditSupplierScreenState createState() => _EditSupplierScreenState();
}

class _EditSupplierScreenState extends State<EditSupplierScreen> {
  final GlobalKey<FormState> _editSupplierGlobalKey = GlobalKey<FormState>();
  String? _personName, _companyName, _phoneNumber, _companyAddress;

  @override
  void initState() {
    super.initState();
    _personName = widget.personName;
    _companyName = widget.companyName;
    _phoneNumber = widget.phoneNumber;
    _companyAddress = widget.companyAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Data Supplier'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Form(
            key: _editSupplierGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  initialValue: _personName,
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
                  initialValue: _companyName,
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
                  initialValue: _phoneNumber,
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
                    } else if (value[0] != '+') {
                      return 'Mohon awali dengan +62';
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: _companyAddress,
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
                          if (_editSupplierGlobalKey.currentState!.validate()) {
                            _editSupplierGlobalKey.currentState!.save();
                            try {
                              await appState.editSupplier(
                                  personName: _personName,
                                  companyName: _companyName,
                                  phoneNumber: _phoneNumber,
                                  companyAddress: _companyAddress,
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
