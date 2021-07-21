import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_model.dart';

class ApplicationState extends ChangeNotifier {
  String? _email = 'unknown', _username = "no name";
  String? name;
  String? stockCode;
  int? expectedIncome;
  int? quantity;
  List<StockAvailable> _stockAvailableList = [
    StockAvailable(
        name: 'Bimoli', stockCode: "B029", quantity: 29, expectedIncome: 10000)
  ];
  List<StockAvailable> get stockAvailableList => _stockAvailableList;
  String get getEmail => _email!;

  String get getUsername => _username!;

  set setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set setusername(String? username) {
    _username = username;
    notifyListeners();
  }

  void addStockAvailable({
    required String? name,
    required String? stockCode,
    required int? expectedIncome,
    required int? quantity,
  }) {
    _stockAvailableList.add(StockAvailable(
        expectedIncome: expectedIncome,
        name: name,
        quantity: quantity,
        stockCode: stockCode));
    notifyListeners();
  }
}
