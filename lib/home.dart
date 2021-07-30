import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/auth.dart';
import 'package:test_aplikasi_tugas_akhir/input_new_stock_screen.dart';
import 'package:test_aplikasi_tugas_akhir/login_screen.dart';
import 'package:test_aplikasi_tugas_akhir/owner_drawer.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/stock_in_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/stock_out_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_screen.dart';

AuthService _auth = AuthService();
User? currentUser = FirebaseAuth.instance.currentUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 1;
  String filter = '';
  // TabController? _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: selectedIndex,
      child: Scaffold(
        floatingActionButton: _bottomButtons(),
        appBar: AppBar(
          title: Text('My Stock'),
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
          bottom: TabBar(
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
                print(selectedIndex);
              },
              tabs: [
                Tab(
                  child: Text('Stok Masuk', style: TextStyle(fontSize: 16.0)),
                ),
                Tab(
                  child:
                      Text('Stok Tersedia', style: TextStyle(fontSize: 16.0)),
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

  Widget _bottomButtons() {
    return selectedIndex == 1
        ? FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputNewStockScreen()),
              );
            },
            icon: Icon(Icons.add),
            label: Text('Stok Tersedia'),
          )
        : FloatingActionButton.extended(
            icon: Icon(Icons.people),
            label: Text('supplier'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupplierScreen()),
              );
            },
          );
  }
}
