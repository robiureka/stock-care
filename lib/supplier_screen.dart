import 'package:flutter/material.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier'),
      ),
      body: Container(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Heru Sunandar'),
                subtitle: Text('Sari Roti'),
                onTap: () {
                  print('supplier ini terklik');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
