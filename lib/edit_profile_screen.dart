import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final String username, phoneNumber, address;
  const EditProfileScreen(
      {Key? key,
      required this.username,
      required this.address,
      required this.phoneNumber})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _updateProfileGlobalKey = GlobalKey<FormState>();
  String? _username, _phoneNumber, _address;
  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _phoneNumber = widget.phoneNumber;
    _address = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perbarui Profil'),
      ),
      body: SingleChildScrollView(
        child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                child: Form(
                  key: _updateProfileGlobalKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        initialValue: _username,
                        onChanged: (value) {
                          setState(() {
                            _username = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Nama Anda',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == '' || value!.isEmpty) {
                            return 'Mohon isi Nama Anda';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        initialValue: _phoneNumber,
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Nomor Telepon',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == '' || value!.isEmpty) {
                            return 'Mohon isi Nomor Telepon';
                          } else if (value[0] != '+') {
                            return 'Mohon Awali dengan +62';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        initialValue: _address,
                        onChanged: (value) {
                          setState(() {
                            _address = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Alamat',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == '' || value!.isEmpty) {
                            return 'Mohon isi Alamat';
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
                                if (_updateProfileGlobalKey.currentState!
                                    .validate()) {
                                  _updateProfileGlobalKey.currentState!.save();
                                  try {
                                    appState.setusername = _username;
                                    await appState.updateProfile(
                                        username: _username,
                                        phoneNumber: _phoneNumber,
                                        address: _address);
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                }
                              },
                              child: Text(
                                'CONFIRM',
                                style:
                                    TextStyle(letterSpacing: 2, fontSize: 18),
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
