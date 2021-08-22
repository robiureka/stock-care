import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final format = new DateFormat('dd-MMM-yyyy');

class StockAvailableDetailScreen extends StatelessWidget {
  final String? name, stockCode;
  final int? quantity, price, expectedIncome, createdAt, updatedAt;
  const StockAvailableDetailScreen(
      {Key? key,
      this.name,
      this.stockCode,
      this.quantity,
      this.price,
      this.expectedIncome,
      this.createdAt,
      this.updatedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Stok Tersedia'),
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
                    Text('Ekspektasi Keuntungan:'),
                    Text(NumberFormat.currency(locale: 'in ', decimalDigits: 0)
                        .format(expectedIncome)
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
