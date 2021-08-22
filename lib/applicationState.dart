import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:test_aplikasi_tugas_akhir/invoice_model.dart';
import 'package:test_aplikasi_tugas_akhir/stock_model.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';

class ApplicationState extends ChangeNotifier {
  String? _email = 'unknown',
      _username = "no name",
      _stockAvailableDocID,
      _customerName,
      _uid;
  String _filter = '';
  String? _supplierName, _companyName, _phoneNumber, _companyAddress;

  String get getCustomerName => _customerName!;
  set setCustomerName(String customerName) {
    _customerName = customerName;
  }

  String get getUid => _uid!;
  set setUid(String uid) {
    _uid = uid;
  }

  String get getEmail => _email!;
  set setEmail(String email) {
    _email = email;
  }

  String get getSupplierName => _supplierName!;
  set setSupplierName(String supplierName) {
    _supplierName = supplierName;
  }

  String get getPhoneNumber => _phoneNumber!;
  set setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  String get getCompanyName => _companyName!;
  set setCompanyName(String companyName) {
    _companyName = companyName;
  }

  String get getCompanyAddress => _companyAddress!;
  set setCompanyAddress(String companyAddress) {
    _companyAddress = companyAddress;
  }

  String get stockAvailableDocID => _stockAvailableDocID!;
  List<Stock> _stockAvailableList = [];
  List<Stock> get stockAvailableList {
    return _stockAvailableList;
  }

  List<String> _supplierList = [];
  List<String> get supplierList => _supplierList;
  set setSupplierList(List<String> supplierList) {
    _supplierList = supplierList;
  }

  List<Supplier> _supplierObjectList = [];
  List<Supplier> get supplierObjectList => _supplierObjectList;
  set setSupplierObjectList(List<Supplier> supplierObjectList) {
    _supplierObjectList = supplierObjectList;
  }

  List<Stock> _stockToStockOutList = [];
  List<Stock> get stockToStockOutList => _stockToStockOutList;
  set setStockToStockOutList(List<Stock> stockToStockOutList) {
    _stockToStockOutList = stockToStockOutList;
  }
  List<Stock> _lowStockList = [];
  List<Stock> get lowStockList => _lowStockList;
  set setLowStockList(List<Stock> lowStockList) {
    _lowStockList = lowStockList;
  }

  List<InvoiceItem> _stockInToInvoiceItem = [];
  List<InvoiceItem> get stockInToInvoiceItem => _stockInToInvoiceItem;
  set setStockInToInvoiceItem(List<InvoiceItem> stockInToInvoiceItem) {
    _stockInToInvoiceItem = stockInToInvoiceItem;
  }

  List<InvoiceItem> _stockOutToInvoiceItem = [];
  List<InvoiceItem> get stockOutToInvoiceItem => _stockOutToInvoiceItem;
  set setStockOutToInvoiceItem(List<InvoiceItem> stockOutToInvoiceItem) {
    _stockOutToInvoiceItem = stockOutToInvoiceItem;
  }

  List<InvoiceItem> _adminStockInToInvoiceItem = [];
  List<InvoiceItem> get adminStockInToInvoiceItem => _adminStockInToInvoiceItem;
  set setAdminStockInToInvoiceItem(
      List<InvoiceItem> adminStockInToInvoiceItem) {
    _adminStockInToInvoiceItem = adminStockInToInvoiceItem;
  }

  List<InvoiceItem> _adminStockOutToInvoiceItem = [];
  List<InvoiceItem> get adminStockOutToInvoiceItem =>
      _adminStockOutToInvoiceItem;
  set setAdminStockOutToInvoiceItem(
      List<InvoiceItem> adminStockOutToInvoiceItem) {
    _adminStockOutToInvoiceItem = adminStockOutToInvoiceItem;
  }

  Future<void> getSupplier(String uid) async {
    QuerySnapshot docsnapshot = await FirebaseFirestore.instance
        .collection('supplier')
        .where('uid', isEqualTo: uid)
        .get();
    docsnapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      _supplierList.add(data['nama supplier']);
    });
  }

  Future<void> getSupplierObject(String uid) async {
    QuerySnapshot docsnapshot = await FirebaseFirestore.instance
        .collection('supplier')
        .where('uid', isEqualTo: uid)
        .get();
    docsnapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      _supplierObjectList.add(Supplier(
          personName: data['nama supplier'],
          phoneNumber: data['nomor supplier']));
    });
  }

  set setStockAvailableList(List<Stock> stockAvailableList) {
    _stockAvailableList = stockAvailableList;
    notifyListeners();
  }

  String get getUsername => _username!;

  String get filter => _filter;

  set setFilter(String filter) {
    _filter = filter;
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
    required String? username,
    required int? price,
  }) {
    return FirebaseFirestore.instance.collection('available-stocks').add({
      'nama barang': name,
      'kode barang': stockCode,
      'kuantitas': quantity,
      'harga satuan': price,
      'ekspektasi keuntungan': expectedIncome,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'username': username,
      'email': FirebaseAuth.instance.currentUser!.email,
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
    required String? username,
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
    return FirebaseFirestore.instance.collection('supplier').add({
      'nama supplier': personName,
      'nama perusahaan': companyName,
      'nomor supplier': phoneNumber,
      'alamat perusahaan': companyAddress,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'username': FirebaseAuth.instance.currentUser!.displayName,
      'email': FirebaseAuth.instance.currentUser!.email,
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
        .collection('supplier')
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
      'username': FirebaseAuth.instance.currentUser!.displayName,
      'email': FirebaseAuth.instance.currentUser!.email,
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
    return FirebaseFirestore.instance
        .collection('stock-in')
        .doc(documentID)
        .update({
      'nama barang': name,
      'kode barang': stockCode,
      'nama supplier': supplierName,
      'kuantitas': quantity,
      'harga satuan': price,
      'dana keluar': outflows,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<DocumentReference> addStockOutFirestore({
    required String? name,
    required String? stockCode,
    required int? incomingFunds,
    required int? quantity,
    required int? price,
  }) {
    return FirebaseFirestore.instance.collection('stock-out').add({
      'nama barang': name,
      'kode barang': stockCode,
      'kuantitas': quantity,
      'harga satuan': price,
      'dana masuk': incomingFunds,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'username': FirebaseAuth.instance.currentUser!.displayName,
      'email': FirebaseAuth.instance.currentUser!.email,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> editStockOutFirestore({
    required String? name,
    required String? stockCode,
    required int? incomingFunds,
    required int? quantity,
    required int? price,
    required String? documentID,
  }) {
    return FirebaseFirestore.instance
        .collection('stock-out')
        .doc(documentID)
        .update({
      'nama barang': name,
      'kode barang': stockCode,
      'kuantitas': quantity,
      'harga satuan': price,
      'dana masuk': incomingFunds,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> updateProfile({
    required String? username,
    required String? phoneNumber,
    required String? address,
  }) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'username': username,
      'nomor telepon': phoneNumber,
      'alamat': address,
    });
  }
}
