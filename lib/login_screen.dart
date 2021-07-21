import 'package:test_aplikasi_tugas_akhir/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 230,
                    width: 300,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      fit: StackFit.loose,
                      children: <Widget>[
                        Positioned(
                          right: 150,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            child: Container(
                              height: 180,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.red.shade700,
                                border: Border.all(color: Colors.red.shade700),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 130,
                          top: 20,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(120)),
                            child: Image.asset(
                              'images/login_screen_hero2.jpg',
                              height: 180,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        'Login Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Please enter your authentication to feel the real experience',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: UsernamePasswordField(),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          }));
                        },
                        child: RichText(
                            text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: ' Sign Up Now',
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                ))
                          ],
                        )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
