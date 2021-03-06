import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:test_aplikasi_tugas_akhir/invoice_model.dart';
import 'package:test_aplikasi_tugas_akhir/pdf_api.dart';
import 'package:test_aplikasi_tugas_akhir/supplier_model.dart';
import 'package:test_aplikasi_tugas_akhir/user_model.dart';
import 'package:test_aplikasi_tugas_akhir/utils.dart';

class PdfInvoiceApi {
  Future<File> generateStockInInvoice(
      Invoice invoice, int invoiceNumber) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) {
        return [
          buildTitle(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildHeader(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoiceStockIn(invoice),
          Divider(),
          buildTotal(invoice),
          pw.SizedBox(
              child: pw.Container(
                child: pw.Row(
                  children: [
                    pw.Spacer(flex: 6),
                    pw.Expanded(
                      flex: 4,
                      child: buildText(
                          title: 'Status: ',
                          value: '*Invoice ini belum dibayar'),
                    )
                  ],
                ),
              ),
              height: 1 * PdfPageFormat.cm),
        ];
      },
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(
        name:
            'Stok-Masuk-${FirebaseAuth.instance.currentUser!.displayName}-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}-$invoiceNumber.pdf',
        pdf: pdf);
  }

  Future<File> generateStockInInvoiceByAdmin(
      Invoice invoice, int invoiceNumber) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) {
        return [
          buildTitle(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildHeader(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoiceStockIn(invoice),
          Divider(),
          buildTotal(invoice),
          pw.SizedBox(
              child: pw.Container(
                child: pw.Row(
                  children: [
                    pw.Spacer(flex: 6),
                    pw.Expanded(
                      flex: 4,
                      child: buildText(
                          title: 'Status: ',
                          value: '*Invoice ini sudah dibayar'),
                    )
                  ],
                ),
              ),
              height: 1 * PdfPageFormat.cm),
          pw.SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Column(children: [
                  Text("Penerima Barang"),
                  pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
                  Text(invoice.user!.username!),
                ])
              ])
        ];
      },
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(
        name:
            'Stok-Masuk-By Admin-${invoice.user!.username}-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}-$invoiceNumber.pdf',
        pdf: pdf);
  }

  Future<File> generateBuktiPenerimaanBarangByAdmin(
      Invoice invoice, int invoiceNumber) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) {
        return [
          buildBuktiPenerimaanTitle(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildBuktiPenerimaanBarangHeader(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoiceStockIn(invoice),
          Divider(),
          buildTotal(invoice),
          pw.SizedBox(
              child: pw.Container(
                child: pw.Row(
                  children: [
                    pw.Spacer(flex: 6),
                    pw.Expanded(
                      flex: 4,
                      child: buildText(
                          title: 'Status: ',
                          value: '*Invoice ini sudah dibayar'),
                    )
                  ],
                ),
              ),
              height: 1 * PdfPageFormat.cm),
          pw.SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Row(

              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Column(

                      children: [
                        Text("Penerima Barang"),
                        pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
                        Text(invoice.user!.username!),
                      ]),
                ),
                pw.Spacer(flex: 6),
                pw.Expanded(
                  flex: 2,
                  child: pw.Column(

                      children: [
                        Text("Pengirim Barang"),
                        pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
                        Text(invoice.supplier!.personName!),
                      ]),
                ),
              ])
        ];
      },
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(
        name:
            'Bukti-Penerimaan-Barang-By Admin-${invoice.user!.username}-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}-$invoiceNumber.pdf',
        pdf: pdf);
  }

  Future<File> generateStockOutInvoice(
      Invoice invoice, int invoiceNumber) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) {
        return [
          buildTitle(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildHeader(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoiceStockOut(invoice),
          Divider(),
          buildTotal(invoice),
        ];
      },
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(
        name:
            'Stok-Keluar-${FirebaseAuth.instance.currentUser!.displayName}-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}-$invoiceNumber.pdf',
        pdf: pdf);
  }

  Future<File> generateStockOutInvoiceByAdmin(
      Invoice invoice, int invoiceNumber) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) {
        return [
          buildTitle(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildHeader(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoiceStockOut(invoice),
          Divider(),
          buildTotal(invoice),
        ];
      },
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(
        name:
            'Stok-Keluar-By Admin-${invoice.user!.username}-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}-$invoiceNumber.pdf',
        pdf: pdf);
  }

  Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildSupplierAddress(invoice.supplier!),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info!.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.user!),
              buildInvoiceInfo(invoice.info!),
            ],
          ),
        ],
      );
  Widget buildBuktiPenerimaanBarangHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildSupplierAddress(invoice.supplier!),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info!.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.user!),
              buildInvoiceInfo(invoice.info!),
            ],
          ),
        ],
      );

  Widget buildCustomerAddress(UserInApp userInApp) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userInApp.username!,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(userInApp.uid!),
          Text(userInApp.email!),
        ],
      );
  Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.personName!,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          // Text(supplier.companyName!),
          // Text(supplier.companyAddress!),
          // Text(supplier.phoneNumber!),
        ],
      );

  Widget buildInvoiceInfo(InvoiceInfo info) {
    // final format = new DateFormat('dd-MMM-yyyy');

    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
    ];

    return Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  Widget buildTitle(Invoice invoice) => Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info!.description, textAlign: pw.TextAlign.center),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      ));
  Widget buildBuktiPenerimaanTitle(Invoice invoice) => Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          Text(
            'BUKTI PENERIMAAN BARANG',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info!.description, textAlign: pw.TextAlign.center),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      ));

  Widget buildInvoiceStockIn(Invoice invoice) {
    final headers = [
      'Nama Barang',
      'Kode Barang',
      'Supplier',
      'Harga Satuan',
      'Kuantitas',
      'Dana Keluar'
    ];
    final data = invoice.items!.map((item) {
      // final total = item.unitPrice! * item.quantity!;

      return [
        item.name!,
        item.stockCode,
        item.supplierName,
        '${NumberFormat.currency(locale: 'in ', decimalDigits: 0).format(item.price)}',
        '${item.quantity!}',
        '${NumberFormat.currency(locale: 'in ', decimalDigits: 0).format(item.outflows)}',
        // '\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      headerAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  Widget buildInvoiceStockOut(Invoice invoice) {
    final headers = [
      'Nama Barang',
      'Kode Barang',
      'Harga Satuan',
      'Kuantitas',
      'Dana Masuk'
    ];
    final data = invoice.items!.map((item) {
      // final total = item.unitPrice! * item.quantity!;

      return [
        item.name!,
        item.stockCode,
        '${NumberFormat.currency(locale: 'in ', decimalDigits: 0).format(item.price)}',
        '${item.quantity!}',
        '${NumberFormat.currency(locale: 'in ', decimalDigits: 0).format(item.incomingFunds)}',
        // '\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      headerAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  // Widget buildNoteInfo() {
  //   return pw.Container(
  //       child: pw.Row(children: [
  //     pw.Spacer(flex: 6),
  //     pw.Expanded(
  //       flex: 4,
  //       child: buildText(value: '*Invoice ini belum dibayar'),
  //     )
  //   ]));
  // }

  Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items!
        .map((item) => item.price! * item.quantity!)
        .reduce((item1, item2) => item1 + item2);

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: NumberFormat.currency(locale: 'in ', decimalDigits: 0)
                      .format(netTotal),
                  unite: true,
                ),
                Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: NumberFormat.currency(locale: 'in ', decimalDigits: 0).format(netTotal),
                //   unite: true,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          buildSimpleText(
              title: '',
              value:
                  'Jika terjadi kendala harap hubungi administrator melalui kontak di bawah ini'),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Email Administrator:', value: 'urekarobby@gmail.com'),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Metode Pembayaran:',
              value: 'Transfer ke Rek BNI A.N. CV. Stok Care Indo 9837378749'),
          SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
