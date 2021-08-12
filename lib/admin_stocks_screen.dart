import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/admin_stock_available_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/admin_stock_in_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/admin_stock_out_tabView.dart';

class AdminStocksScreen extends StatefulWidget {
  const AdminStocksScreen({Key? key}) : super(key: key);

  @override
  _AdminStocksScreenState createState() => _AdminStocksScreenState();
}

class _AdminStocksScreenState extends State<AdminStocksScreen>
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
        appBar: AppBar(
          title: Text('Admin Stocks'),
          centerTitle: true,
        
          bottom: TabBar(
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              tabs: [
                Tab(
                  child: Text('Stok Masuk', style: TextStyle(fontSize: 13.0)),
                ),
                Tab(
                  child:
                      Text('Stok Tersedia', style: TextStyle(fontSize: 13.0)),
                ),
                Tab(
                  child: Text('Stok Keluar', style: TextStyle(fontSize: 13.0)),
                ),
              ]),
        ),
        body: TabBarView(children: [
          AdminStockInTabView(),
          AdminStockAvailableTabView(),
          AdminStockOutTabView(),
        ]),
      ),
    );
  }
}
