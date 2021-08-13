import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/admin_stock_out_reports_tabView.dart';
import 'package:test_aplikasi_tugas_akhir/admin_stock_in_reports_tabView.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({Key? key}) : super(key: key);

  @override
  _AdminReportsScreenState createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen>
    with SingleTickerProviderStateMixin {

  int selectedIndex = 0;
  // TabController? _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: selectedIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Reports'),
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
                      Text('Stok Keluar', style: TextStyle(fontSize: 13.0)),
                ),
              ]),
        ),
        body: TabBarView(children: [
          AdminStockInReportsTabView(),
          AdminStockOutReportsTabView(),
        ]),
      ),
    );
  }
}
