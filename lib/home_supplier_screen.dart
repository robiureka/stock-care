import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/auth.dart';
import 'package:test_aplikasi_tugas_akhir/login_screen.dart';

class SupplierHomeScreen extends StatelessWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('clicked');
            },
            child: Icon(Icons.add)),
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  await _auth.signOut().then((result) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
                icon: Icon(Icons.logout))
          ],
          bottom: TabBar(tabs: [
            Tab(
              child: Text('Permintaan', style: TextStyle(fontSize: 16.0)),
            ),
            Tab(
              child: Text('Riwayat', style: TextStyle(fontSize: 16.0)),
            ),
          ]),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
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
                  print('My Stock clicked');
                },
                selected: true,
              ),
              SizedBox(height: 10.0),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('My Profile'),
                onTap: () {
                  print('Profile clicked');
                },
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          Center(
            child: Text('Permintaan'),
          ),
          Center(
            child: Text('Riwayat'),
          ),
        ]),
      ),
    );
  }
}
