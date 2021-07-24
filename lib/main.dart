import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/home.dart';
import 'package:test_aplikasi_tugas_akhir/home_supplier_screen.dart';
import 'package:test_aplikasi_tugas_akhir/login_screen.dart';
import 'package:test_aplikasi_tugas_akhir/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ApplicationState>(
    create: (context) => ApplicationState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Wrapper());
  }
}
