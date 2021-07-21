import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';

class StockOutTabView extends StatefulWidget {
  const StockOutTabView({Key? key}) : super(key: key);

  @override
  _StockOutTabViewState createState() => _StockOutTabViewState();
}

class _StockOutTabViewState extends State<StockOutTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) =>
          Center(child: Text('Hello, Stok Keluar')),
    );
  }
}
