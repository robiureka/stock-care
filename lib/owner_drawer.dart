import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/profile_screen.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_screen.dart';

class OwnerDrawer extends StatelessWidget {
  const OwnerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => Text(
                    appState.getUsername,
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('My Stock'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 10.0),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Supplier'),
            onTap: () {
              print('Supplier clicked');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupplierScreen()));
            },
          ),
          SizedBox(height: 10.0),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Profile'),
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          )
        ],
      ),
    );
  }
}
