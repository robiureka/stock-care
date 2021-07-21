
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        'Create your new account with fill these fields below',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: SignUpForm(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                      text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          text: ' Sign In Now',
                          style: TextStyle(
                            color: Colors.red.shade700,
                          ))
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


