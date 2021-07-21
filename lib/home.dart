import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/auth.dart';
import 'package:test_aplikasi_tugas_akhir/input_new_stock_dialog.dart';
import 'package:test_aplikasi_tugas_akhir/login_screen.dart';
import 'package:test_aplikasi_tugas_akhir/owner_drawer.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/stock_in_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/stock_out_tabView.dart';

AuthService _auth = AuthService();
User? currentUser = FirebaseAuth.instance.currentUser;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: InputNewStockDialog(),
                    )),
            child: Icon(Icons.add)),
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  await _auth.signOut().then((result) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
                icon: Icon(Icons.logout))
          ],
          bottom: TabBar(tabs: [
            Tab(
              child: Text('Stok Masuk', style: TextStyle(fontSize: 16.0)),
            ),
            Tab(
              child: Text('Stok Tersedia', style: TextStyle(fontSize: 16.0)),
            ),
            Tab(
              child: Text('Stok Keluar', style: TextStyle(fontSize: 16.0)),
            ),
          ]),
        ),
        drawer: OwnerDrawer(),
        body: TabBarView(children: [
          StockInTabView(),
          StockAvailableTabView(),
          StockOutTabView(),
        ]),
      ),
    );
  }
}
