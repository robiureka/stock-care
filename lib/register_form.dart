import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/auth.dart';
import 'package:test_aplikasi_tugas_akhir/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _confirmPassword = '', username = '';
  bool? isOwner;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            onSaved: (String? value) {
              setState(() {
                _email = value!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Email',
              hintText: "example@example.com",
            ),
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
          ),
          SizedBox(height: 18),
          TextFormField(
            onSaved: (String? value) {
              setState(() {
                username = value!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Username',
              hintText: "Username",
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Username';
              }
              return null;
            },
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Radio(
                value: true,
                groupValue: isOwner,
                onChanged: (bool? val) {
                  setState(() {
                    isOwner = val!;
                  });
                },
              ),
              Text('Pemilik Toko'),
              Radio(
                value: false,
                groupValue: isOwner,
                onChanged: (bool? val) {
                  setState(() {
                    isOwner = val!;
                  });
                },
              ),
              Text('Distributor'),
            ],
          ),
          SizedBox(height: 18),
          TextFormField(
            onChanged: (String? value) {
              setState(() {
                _password = value!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Password',
              hintText: "12+ Characters",
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Password';
              } else if (value.length < 12) {
                return 'Password must be at least 12 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 18),
          TextFormField(
            onChanged: (String value) {
              setState(() {
                _confirmPassword = value;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Confirm Password',
              hintText: "Confirm Password",
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter to confirm the Password';
              } else if (_confirmPassword != _password) {
                return 'Please Enter the Password correctly';
              }
              return null;
            },
          ),
          SizedBox(height: 25),
          Text(
            'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black45,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade700,
                ),
                onPressed: () async {
                  dynamic result;
                  AuthService _auth = AuthService();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      result =
                          await _auth.createUser(_email, _password, username);
                      print(_email);
                      print(_password);
                      print(result);
                      if (result !=
                          'The account already exists for that email.') {
                        try {
                          await firestore.collection('users').doc(result.uid).set({
                            'username': username,
                            'email': _email,
                            'uid': result.uid,
                            'isOwner': isOwner,
                          });
                        } catch (e) {
                          print(e.toString());
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        FirebaseAuth.instance.signOut();
                        _formKey.currentState!.reset();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(result),
                                ));
                      }
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text(e.toString()),
                              ));
                    }
                  }
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(letterSpacing: 2, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
