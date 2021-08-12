
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';
import 'package:test_aplikasi_tugas_akhir/user_model.dart';

class Invoice {
  final InvoiceInfo? info;
  final Supplier? supplier;
  final UserInApp? user;
  List<InvoiceItem>? items;
  List<InvoiceItem> get itemList => items!;
  set setItemList(List<InvoiceItem> itemList) {
    items = itemList;
  }

  Invoice({
    this.info,
    this.supplier,
    this.user,
    this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  DateTime? dueDate;

  InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    this.dueDate,
  });
}

class InvoiceItem {
  String? description, name, stockCode, supplierName;
  DateTime? date;
  int? quantity, price, outflows, incomingFunds;
  double? vat;
  double? unitPrice;

  InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });

  InvoiceItem.masuk(
      {required this.name,
      required this.stockCode,
      required this.quantity,
      required this.outflows,
      required this.supplierName,
      required this.price});

  InvoiceItem.keluar(
      {required this.name,
      required this.stockCode,
      required this.quantity,
      required this.incomingFunds,
      required this.price});
}
