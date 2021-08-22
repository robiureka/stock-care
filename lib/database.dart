import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

import 'package:path/path.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final FirebaseFirestore db = FirebaseFirestore.instance;
Future<bool> getUserByRole(String uid) async {
  DocumentSnapshot doc = await usersRef.doc(uid).get();
  return doc['isOwner'];
}

Future<void> saveReportStockInByAdmin(File pdfFile, int invoiceNumber) async {
  fs.Reference ref = fs.FirebaseStorage.instance
      .ref()
      .child('reports')
      .child(basename(pdfFile.path));
  fs.UploadTask task = ref.putFile(pdfFile);
  fs.TaskSnapshot snapshot = await task.whenComplete(() {});
  String downloadURL = await snapshot.ref.getDownloadURL();
  await db.collection('reports').add({
    'isPaid': true,
    'username': FirebaseAuth.instance.currentUser!.displayName,
    'download_url': downloadURL,
    'invoice_number':
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
    'created_at': DateTime.now().millisecondsSinceEpoch,
    'updated_at': DateTime.now().millisecondsSinceEpoch,
    'category': 'stock-in',
    'created_by': 'admin',
  });
}

Future<void> saveReportStockOutByAdmin(File pdfFile, int invoiceNumber) async {
  fs.Reference ref = fs.FirebaseStorage.instance
      .ref()
      .child('reports')
      .child(basename(pdfFile.path));
  fs.UploadTask task = ref.putFile(pdfFile);
  fs.TaskSnapshot snapshot = await task.whenComplete(() {});
  String downloadURL = await snapshot.ref.getDownloadURL();
  await db.collection('reports').add({
    'username': FirebaseAuth.instance.currentUser!.displayName,
    'download_url': downloadURL,
    'invoice_number':
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
    'created_at': DateTime.now().millisecondsSinceEpoch,
    'updated_at': DateTime.now().millisecondsSinceEpoch,
    'category': 'stock-out',
    'created_by': 'admin',
  });
}

Future<void> saveReportStockInByUser(File pdfFile, int invoiceNumber) async {
  fs.Reference ref = fs.FirebaseStorage.instance
      .ref()
      .child('reports')
      .child(basename(pdfFile.path));
  fs.UploadTask task = ref.putFile(pdfFile);
  fs.TaskSnapshot snapshot = await task.whenComplete(() {});
  String downloadURL = await snapshot.ref.getDownloadURL();
  await db.collection('reports').add({
    'isPaid': false,
    'isSent': false,
    'hasBuktiTransfer': false,
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'username': FirebaseAuth.instance.currentUser!.displayName,
    'download_url': downloadURL,
    'invoice_number':
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
    'created_at': DateTime.now().millisecondsSinceEpoch,
    'updated_at': DateTime.now().millisecondsSinceEpoch,
    'category': 'stock-in',
    'created_by': "user",
  });
}

Future<void> saveReportStockOutByUser(File pdfFile, int invoiceNumber) async {
  fs.Reference ref = fs.FirebaseStorage.instance
      .ref()
      .child('reports')
      .child(basename(pdfFile.path));
  fs.UploadTask task = ref.putFile(pdfFile);
  fs.TaskSnapshot snapshot = await task.whenComplete(() {});
  String downloadURL = await snapshot.ref.getDownloadURL();
  await db.collection('reports').add({
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'username': FirebaseAuth.instance.currentUser!.displayName,
    'download_url': downloadURL,
    'invoice_number':
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
    'created_at': DateTime.now().millisecondsSinceEpoch,
    'updated_at': DateTime.now().millisecondsSinceEpoch,
    'category': 'stock-out',
    'created_by':"user",
  });
}

Future<void> saveBuktiPenerimaanBarang(File pdfFile, int invoiceNumber) async {
  fs.Reference ref = fs.FirebaseStorage.instance
      .ref()
      .child('reports')
      .child(basename(pdfFile.path));
  fs.UploadTask task = ref.putFile(pdfFile);
  fs.TaskSnapshot snapshot = await task.whenComplete(() {});
  String downloadURL = await snapshot.ref.getDownloadURL();
  await db.collection('reports').add({
    'isSigned': false,
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'username': FirebaseAuth.instance.currentUser!.displayName,
    'download_url': downloadURL,
    'invoice_number':
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-$invoiceNumber',
    'created_at': DateTime.now().millisecondsSinceEpoch,
    'updated_at': DateTime.now().millisecondsSinceEpoch,
    'category': 'bukti-penerimaan-barang',
    'created_by': 'admin',
  });
}
