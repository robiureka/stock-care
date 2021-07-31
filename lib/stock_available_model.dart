import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class Stock {
  Supplier? supplier;
  String? name, stockCode, supplierName;
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
}

// List<StockAvailable> stockAvailableList = [
//   StockAvailable(
//       name: "Minyak Goreng Bimoli",
//       expectedIncome: 100000,
//       quantity: 1234,
//       stockCode: "A09B"),
//   StockAvailable(
//       name: "Minyak Goreng Palmia",
//       expectedIncome: 410012,
//       quantity: 76,
//       stockCode: "A09C"),
//   StockAvailable(
//       name: "Air Mineral Aqua",
//       expectedIncome: 8451000,
//       quantity: 1345,
//       stockCode: "Z09C"),
//   StockAvailable(
//       name: "Le Minerale",
//       expectedIncome: 7010000,
//       quantity: 4345,
//       stockCode: "Z09D"),
// ];
