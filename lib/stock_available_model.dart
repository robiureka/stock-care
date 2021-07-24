class StockAvailable {
  String? name, stockCode;
  int? quantity, expectedIncome, price, created_at;

  StockAvailable(
      {this.name, this.stockCode, this.quantity,this.created_at, this.expectedIncome, this.price});
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
