import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';

class StockInTabView extends StatefulWidget {
  const StockInTabView({Key? key}) : super(key: key);

  @override
  _StockInTabViewState createState() => _StockInTabViewState();
}

class _StockInTabViewState extends State<StockInTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) =>
          Center(child: Text('Hello, Stok Masuk')),
    );
  }
}
