class Report {
  String? downloadURL, uid, username, invoiceNumber, createdBy, buktiTransferURL;
  bool? isPaid, isSent, hasBuktiTransfer, isSigned;
  int? createdAt, updatedAt;
  Report.stockIn({
    this.buktiTransferURL,
    this.isSent,
    this.hasBuktiTransfer,
    this.createdBy,
    this.isPaid,
    this.username,
    this.uid,
    this.invoiceNumber,
    this.downloadURL,
    this.createdAt,
    this.updatedAt,
  });
  Report.stockOut({
    this.createdBy,
    this.username,
    this.uid,
    this.invoiceNumber,
    this.downloadURL,
    this.createdAt,
    this.updatedAt,
  });
  Report.buktiPenerimaanBarang({
    this.createdBy,
    this.username,
    this.uid,
    this.invoiceNumber,
    this.downloadURL,
    this.createdAt,
    this.updatedAt,
    this.isSigned,
  });
}