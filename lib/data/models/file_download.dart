class FileDownload {
  int? downloadId;
  int? reconciliationReferenceId;
  String? reconciliationReference;
  String? createdDate;
  String? sheetOneResultPath;
  String? sheetTwoResultPath;

  FileDownload({
    this.downloadId,
    this.reconciliationReferenceId,
    this.reconciliationReference,
    this.createdDate,
    this.sheetOneResultPath,
    this.sheetTwoResultPath,
  });

  FileDownload.fromJson(Map<String, dynamic> json) {
    downloadId = json['DownloadId'];
    reconciliationReferenceId = json['ReconciliationReferenceId'];
    reconciliationReference = json['ReconciliationReference'];
    createdDate = json['CreatedDate'];
    sheetOneResultPath = json['SheetOneResultPath'];
    sheetTwoResultPath = json['SheetTwoResultPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DownloadId'] = downloadId;
    data['ReconciliationReferenceId'] = reconciliationReferenceId;
    data['ReconciliationReference'] = reconciliationReference;
    data['CreatedDate'] = createdDate;
    data['SheetOneResultPath'] = sheetOneResultPath;
    data['SheetTwoResultPath'] = sheetTwoResultPath;
    return data;
  }
}
