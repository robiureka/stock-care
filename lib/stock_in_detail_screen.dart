import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final format = new DateFormat('dd-MMM-yyyy');

class StockInDetailScreen extends StatelessWidget {
  final String? name, stockCode, supplierName;
  final int? quantity, price, outflows, createdAt, updatedAt;
  const StockInDetailScreen(
      {Key? key,
      required this.name,
      required this.stockCode,
      required this.supplierName,
      required this.quantity,
      required this.price,
      required this.outflows,
      required this.createdAt,
      required this.updatedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Stok Masuk'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nama Barang:'),
                    Text(name!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kode Barang:'),
                    Text(stockCode!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nama Supplier:'),
                    Text(supplierName!),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kuantitas:'),
                    Text(quantity!.toString()),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Harga Satuan:'),
                    Text(NumberFormat.currency(locale: 'in', decimalDigits: 0)
                        .format(price!)
                        .toString()),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dana Keluar:'),
                    Text(NumberFormat.currency(locale: 'in ', decimalDigits: 0)
                        .format(outflows)
                        .toString()),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dibuat Pada:'),
                    Text(format.format(new DateTime.fromMillisecondsSinceEpoch(createdAt!))),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Diperbarui Pada:'),
                    Text(format.format(new DateTime.fromMillisecondsSinceEpoch(updatedAt!)))
                  ],
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('KEMBALI'),
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(fontSize: 18.0, letterSpacing: 3.0),
                side: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
