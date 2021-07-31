import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_model.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class ApplicationState extends ChangeNotifier {
  String? _email = 'unknown', _username = "no name";
  StreamSubscription<QuerySnapshot>? _stockAvailableSubscription;
  String _filter = '';
  List<Stock> _stockAvailableList = [];
  List<Stock> get stockAvailableList {
    return _stockAvailableList;
  }

  List<String> _supplierList = [];
  List<String> get supplierList => _supplierList;
  set setSupplierList(List<String> supplierList){
    _supplierList = supplierList;
  }



  set setStockAvailableList(List<Stock> stockAvailableList) {
    _stockAvailableList = stockAvailableList;
    notifyListeners();
  }

  String get getEmail => _email!;

  String get getUsername => _username!;

  String get filter => _filter;

  set setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  set setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set setusername(String? username) {
    _username = username;
    notifyListeners();
  }

  Future<DocumentReference> addStockAvailableFirestore({
    required String? name,
    required String? stockCode,
    required int? expectedIncome,
    required int? quantity,
    required int? price,
  }) {
    return FirebaseFirestore.instance.collection('available-stocks').add({
      'nama barang': name,
      'kode barang': stockCode,
      'kuantitas': quantity,
      'harga satuan': price,
      'ekspektasi keuntungan': expectedIncome,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> editStockAvailableFirestore({
    required String? name,
    required String? stockCode,
    required int? expectedIncome,
    required int? quantity,
    required int? price,
    required String? documentID,
  }) {
    return FirebaseFirestore.instance
        .collection('available-stocks')
        .doc(documentID)
        .update({
      'nama barang': name,
      'kode barang': stockCode,
      'kuantitas': quantity,
      'harga satuan': price,
      'ekspektasi keuntungan': expectedIncome,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<DocumentReference> addNewSupplier({
    required String? personName,
    required String? companyName,
    required String? phoneNumber,
    required String? companyAddress,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('supplier-list')
        .add({
      'nama supplier': personName,
      'nama perusahaan': companyName,
      'nomor supplier': phoneNumber,
      'alamat perusahaan': companyAddress,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> editSupplier({
    required String? personName,
    required String? companyName,
    required String? phoneNumber,
    required String? companyAddress,
    required String? documentID,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('supplier-list')
        .doc(documentID)
        .update({
      'nama supplier': personName,
      'nama perusahaan': companyName,
      'nomor supplier': phoneNumber,
      'alamat perusahaan': companyAddress,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<DocumentReference> addStockInFirestore({
    required String? name,
    required String? stockCode,
    required String? supplierName,
    required int? outflows,
    required int? quantity,
    required int? price,
  }) {
    return FirebaseFirestore.instance.collection('stock-in').add({
      'nama barang': name,
      'kode barang': stockCode,
      'nama supplier': supplierName,
      'kuantitas': quantity,
      'harga satuan': price,
      'dana keluar': outflows,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }
  Future<void> editStockInFirestore({
    required String? name,
    required String? stockCode,
    required String? supplierName,
    required int? outflows,
    required int? quantity,
    required int? price,
    required String? documentID,
  }) {
    return FirebaseFirestore.instance.collection('stock-in').doc(documentID).update({
      'nama barang': name,
      'kode barang': stockCode,
      'nama supplier': supplierName,
      'kuantitas': quantity,
      'harga satuan': price,
      'dana keluar': outflows,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }
}




  // void getAllUserStocks(String uid) {
  //   _stockAvailableSubscription = FirebaseFirestore.instance
  //       .collection('available-stocks')
  //       .where('uid', isEqualTo: uid)
  //       .snapshots()
  //       .listen((snapshot) {
  //     _stockAvailableList = [];
  //     snapshot.docs.forEach((document) {
  //       _stockAvailableList.add(StockAvailable(
  //           name: document.data()['nama barang'] as String,
  //           quantity: document.data()['kuantitas'] as int,
  //           stockCode: document.data()['kode barang'] as String,
  //           expectedIncome: document.data()['ekspektasi keuntungan'] as int));
  //     });
  //     notifyListeners();
  //   });
  // }

// FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).collection('available-stocks').add({
//       'nama barang' : name,
//       'kode barang' : stockCode,
//       'kuantitas'   : quantity,
//       'ekspektasi keuntungan' : expectedIncome,
//       'uid' : _auth.currentUser!.uid,
//       'timestamps' : DateTime.now().millisecondsSinceEpoch,
//     });

  // void addStockAvailable({
  //   required String? name,
  //   required String? stockCode,
  //   required int? expectedIncome,
  //   required int? quantity,
  // }) {
  //   _stockAvailableList.add(StockAvailable(
  //       expectedIncome: expectedIncome,
  //       name: name,
  //       quantity: quantity,
  //       stockCode: stockCode));
  //   notifyListeners();
  // }

  // void deleteStockAvailable(int index) {
  //   _stockAvailableList.remove(_stockAvailableList[index]);
  //   notifyListeners();
  // }