class TableRowData {
  int? recordId;
  String? reference;
  String? reference2;
  num? amount;
  String? date;
  String? status;
  String? subStatus;
  String? description;
  int? confirmed;
  String? matchReferenceNumber;
  int? reconciliationReferenceId;

  TableRowData({
    this.recordId,
    this.reference,
    this.reference2,
    this.amount,
    this.date,
    this.status,
    this.subStatus,
    this.description,
    this.confirmed,
    this.matchReferenceNumber,
    this.reconciliationReferenceId,
  });

  TableRowData.fromJson(Map<String, dynamic> json) {
    recordId = json['RecordId'];
    reference = json['Reference'];
    reference2 = json['Reference_2'];
    amount = json['Amount'];
    date = json['Date'];
    status = json['Status'];
    subStatus = json['SubStatus'];
    description = json['Description'];
    confirmed = json['Confirmed'];
    matchReferenceNumber = json['MatchReferenceNumber'];
    reconciliationReferenceId = json['ReconciliationReferenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RecordId'] = recordId;
    data['Reference'] = reference;
    data['Reference_2'] = reference2;
    data['Amount'] = amount;
    data['Date'] = date;
    data['Status'] = status;
    data['SubStatus'] = subStatus;
    data['Description'] = description;
    data['Confirmed'] = confirmed;
    data['MatchReferenceNumber'] = matchReferenceNumber;
    data['ReconciliationReferenceId'] = reconciliationReferenceId;
    return data;
  }
}
