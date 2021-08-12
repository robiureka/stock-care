import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/admin_stocks_screen.dart';
import 'package:test_aplikasi_tugas_akhir/admin_supplier_screen.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/auth.dart';
import 'package:test_aplikasi_tugas_akhir/login_screen.dart';
import 'package:test_aplikasi_tugas_akhir/admin_users_screen.dart';

AuthService _auth = AuthService();
User? currentUser = FirebaseAuth.instance.currentUser;

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 1;
  String filter = '';
  // TabController? _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Administrator Home'),
          centerTitle: true,
          actions: <Widget>[
            Consumer<ApplicationState>(
              builder: (context, appState, _) => IconButton(
                  onPressed: () async {
                    await _auth.signOut().then((result) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    });
                  },
                  icon: Icon(Icons.logout)),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminUsersScreen()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            size: 80,
                            color: Theme.of(context).buttonColor,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Users',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).buttonColor),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminStocksScreen()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory,
                            size: 80,
                            color: Theme.of(context).buttonColor,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Stocks',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).buttonColor),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AdminStocksScreen()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.picture_as_pdf,
                            size: 80,
                            color: Theme.of(context).buttonColor,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Reports',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).buttonColor),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminSupplierScreen()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_alt_outlined,
                            size: 80,
                            color: Theme.of(context).buttonColor,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Supplier',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).buttonColor),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
