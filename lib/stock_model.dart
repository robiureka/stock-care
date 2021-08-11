import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class Stock {
  Supplier? supplier;
  String? name, stockCode, supplierName, username, uid;
  int? quantity,
      expectedIncome,
      price,
      createdAt,
      updatedAt,
      outflows,
      incomingFunds;

  Stock(
      {this.name,
      this.stockCode,
      this.quantity,
      this.createdAt,
      this.expectedIncome,
      this.price});
  Stock.available(
      {this.name,
      this.stockCode,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.expectedIncome,
      this.price});
  Stock.masuk(
      {this.name,
      this.stockCode,
      this.quantity,
      this.outflows,
      this.supplierName,
      this.createdAt,
      this.updatedAt,
      this.price});
  Stock.keluar(
      {this.name,
      this.stockCode,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.incomingFunds,
      this.price});
  Stock.adminAvailable(
      {this.name,
      this.uid,
      this.username,
      this.stockCode,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.expectedIncome,
      this.price});
  Stock.adminMasuk(
      {this.name,
      this.uid,
      this.username,
      this.stockCode,
      this.quantity,
      this.outflows,
      this.supplierName,
      this.createdAt,
      this.updatedAt,
      this.price});
  Stock.adminKeluar(
      {this.name,
      this.uid,
      this.username,
      this.stockCode,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.incomingFunds,
      this.price});
}

