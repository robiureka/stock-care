import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/owner_drawer.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier'),
      ),
      drawer: OwnerDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Container(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Heru Sunandar'),
                subtitle: Text('Sari Roti'),
                contentPadding: EdgeInsets.all(5.0),
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
