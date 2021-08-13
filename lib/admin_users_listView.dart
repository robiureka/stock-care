import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/admin_detail_user_screen.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/auth.dart';
import 'package:test_aplikasi_tugas_akhir/user_model.dart';

class AdminUsersListView extends StatefulWidget {
  final String filter;
  const AdminUsersListView({Key? key, required this.filter}) : super(key: key);

  @override
  _AdminUsersListViewState createState() => _AdminUsersListViewState();
}

class _AdminUsersListViewState extends State<AdminUsersListView> {
  AuthService _auth = AuthService();
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('users')
              .orderBy('username', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<UserInApp> _userInAppList = [];
            _userInAppList = snapshot.data!.docs.map((element) {
              Map<String, dynamic> data =
                  element.data() as Map<String, dynamic>;
              return UserInApp(
                  username: data['username'],
                  email: data['email'],
                  phoneNumber: data['nomor telepon'],
                  uid: element.reference.id,
                  address: data['alamat']);
            }).where((element) {
              final emailLower = element.email!.toLowerCase();
              final nameLower = element.username!.toLowerCase();
              final filterLower = widget.filter.toLowerCase();
              final uidLower = element.uid!.toLowerCase();
              return emailLower.contains(filterLower) ||
                  nameLower.contains(filterLower) || uidLower.contains(filterLower);
            }).toList();
            return (_userInAppList.isEmpty)
                ? Center(child: Text('Kosong'))
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _userInAppList.length,
                    itemBuilder: (context, index) {
                      UserInApp userInApp = _userInAppList[index];
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDetailScreen(
                                        username: userInApp.username,
                                        phoneNumber: userInApp.phoneNumber,
                                        email: userInApp.email,
                                        uid: userInApp.uid,
                                        address: userInApp.address)));
                          },
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Slidable(
                                actionPane: SlidableScrollActionPane(),
                                secondaryActions: [
                                  IconSlideAction(
                                    icon: Icons.delete,
                                    color: Colors.red,
                                    caption: 'delete',
                                    foregroundColor: Colors.white,
                                    onTap: () async {
                                      await document.reference.delete();
                                      _userInAppList
                                          .remove(document.reference.id);
                                    },
                                    closeOnTap: true,
                                  ),
                                ],
                                actions: [
                                  IconSlideAction(
                                    icon: Icons.edit,
                                    color: Colors.green,
                                    caption: 'Reset \nPassword',
                                    foregroundColor: Colors.white,
                                    onTap: () async {
                                      bool send = await _auth
                                          .resetPassword(userInApp.email!);
                                      if (send) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'Email reset password berhasil dikirim',
                                        )));
                                      }
                                    },
                                    closeOnTap: true,
                                  ),
                                ],
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(userInApp.username!),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(userInApp.email!),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                          userInApp.phoneNumber ?? 'tidak ada'),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text('ID Pengguna: ${userInApp.uid!}'),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                    ],
                                  ),
                                ),
                                // onTap: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               UserInAppDetailScreen(
                                //                 personName:
                                //                     userInApp.personName,
                                //                 companyName:
                                //                     userInApp.companyName,
                                //                 phoneNumber:
                                //                     userInApp.phoneNumber,
                                //                 companyAddress:
                                //                     userInApp.companyAddress,
                                //               )));
                                // },
                              ),
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }
}
