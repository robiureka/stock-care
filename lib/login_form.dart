import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/auth.dart';
import 'package:test_aplikasi_tugas_akhir/database.dart';
import 'package:test_aplikasi_tugas_akhir/home.dart';
import 'package:test_aplikasi_tugas_akhir/home_supplier_screen.dart';

class UsernamePasswordField extends StatefulWidget {
  const UsernamePasswordField({Key? key}) : super(key: key);

  @override
  _UsernamePasswordFieldState createState() => _UsernamePasswordFieldState();
}

class _UsernamePasswordFieldState extends State<UsernamePasswordField> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? _email, _password, _username;
  String error = '';
  bool? isOwner = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.red.shade700,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              onSaved: (String? value) {
                setState(() {
                  _email = value!;
                });
              },
              validator: (String? value) {
                final pattern =
                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                final regExp = RegExp(pattern);
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Email';
                } else if (!regExp.hasMatch(value)) {
                  return 'Please Enter a Valid Email';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Your Username',
                icon: Icon(Icons.account_circle),
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.red.shade700,
                )),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            margin: EdgeInsets.only(bottom: 25),
            child: TextFormField(
              onSaved: (String? value) {
                setState(() {
                  _password = value!;
                });
              },
              validator: (String? value) {
                if (value == '' || value!.isEmpty) {
                  return 'Please enter your password';
                }
              },
              decoration: InputDecoration(
                  hintText: 'Your Password',
                  icon: Icon(Icons.lock),
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 60,
              width: double.infinity,
              child: Consumer<ApplicationState>(
                builder: (context, appState, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade700,
                  ),
                  onPressed: () async {
                    dynamic userOrError;
                    AuthService _auth = AuthService();
                    if (_loginFormKey.currentState!.validate()) {
                      _loginFormKey.currentState!.save();
                      print(_email);
                      print(_password);
                      try {
                        userOrError =
                            await _auth.signInUser(_email!, _password!);
                        isOwner = await getUserByRole(userOrError.uid);
                        print(userOrError);
                        appState.setusername = userOrError.displayName;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (isOwner == false)
                                    ? SupplierHomeScreen()
                                    : HomeScreen()));
                        _loginFormKey.currentState!.reset();
                      } catch (e) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(userOrError),
                                ));
                      }
                    }
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(letterSpacing: 3, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
