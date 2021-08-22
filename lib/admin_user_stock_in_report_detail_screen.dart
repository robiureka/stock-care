import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi_tugas_akhir/database.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUserStockInReportDetailScreen extends StatefulWidget {
  final bool isSent, isPaid, hasBuktiTransfer;
  final String invoiceNumber, documentID, buktiTransferURL, downloadURL;
  const AdminUserStockInReportDetailScreen({
    Key? key,
    required this.downloadURL,
    required this.buktiTransferURL,
    required this.isPaid,
    required this.hasBuktiTransfer,
    required this.isSent,
    required this.invoiceNumber,
    required this.documentID,
  }) : super(key: key);

  @override
  _AdminUserStockInReportDetailScreenState createState() =>
      _AdminUserStockInReportDetailScreenState();
}

class _AdminUserStockInReportDetailScreenState
    extends State<AdminUserStockInReportDetailScreen> {
  bool? isSent, isPaid, hasBuktiTransfer;
  String? invoiceNumber, imagePath, downloadURL;
  File? file;

  void openPDFFile(String url) async {
    await canLaunch(url) ? launch(url) : print("Tidak Bisa Membuka File");
  }

  @override
  void initState() {
    super.initState();
    isSent = widget.isSent;
    isPaid = widget.isPaid;
    hasBuktiTransfer = widget.hasBuktiTransfer;
    invoiceNumber = widget.invoiceNumber;
    imagePath = widget.buktiTransferURL;
    downloadURL = widget.downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Report Stok Masuk'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                (hasBuktiTransfer == true)
                    ? Center(
                        child: Container(
                        height: 280,
                        width: 250,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            image: DecorationImage(
                                image: NetworkImage(imagePath!),
                                fit: BoxFit.cover)),
                      ))
                    : Center(
                        child: Container(
                        height: 280,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text("Tidak Ada Bukti Transfer"),
                        ),
                      )),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Nomor Invoice: '), Text(invoiceNumber!)],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status Bayar: '),
                    Text(isPaid! ? "Sudah" : "Belum")
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status Kirim: '),
                    Text(isSent! ? "Sudah" : "Belum")
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bukti Transfer: '),
                    Text(hasBuktiTransfer! ? "Ada" : "Tidak Ada")
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      openPDFFile(downloadURL!);
                    },
                    child: Text('DOWNLOAD INVOICE'),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future selectAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });

    if (file == null) return;
    final fileName = basename(file!.path);
    try {
      Reference ref = FirebaseStorage.instance.ref('buktiTransfer/$fileName');
      UploadTask task = ref.putFile(file!);
      TaskSnapshot snapshot = await task.whenComplete(() {});
      final temporaryImagePath = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('reports')
          .doc(widget.documentID)
          .update({
        'hasBuktiTransfer': true,
        'bukti_transfer_download_url': temporaryImagePath,
      });
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
