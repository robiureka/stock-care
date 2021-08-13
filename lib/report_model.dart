class Report {
  String? downloadURL, uid, username, invoiceNumber, createdBy;
  bool? isPaid;
  int? createdAt, updatedAt;
  Report.stockIn({
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
}