class CompleteRowData {
  int? recordId;
  String? data;
  String? reference;
  double? amount;
  String? date;
  String? status;
  String? subStatus;
  String? description;
  int? confirmed;
  String? matchReferenceNumber;
  int? updateStatus;
  String? updatedBy;
  int? amountUpdated;
  int? referenceUpdated;
  int? dateUpdated;
  String? sequence;
  int? reconciliationReferenceId;
  String? reference2;

  CompleteRowData({
    this.recordId,
    this.data,
    this.reference,
    this.amount,
    this.date,
    this.status,
    this.subStatus,
    this.description,
    this.confirmed,
    this.matchReferenceNumber,
    this.updateStatus,
    this.updatedBy,
    this.amountUpdated,
    this.referenceUpdated,
    this.dateUpdated,
    this.sequence,
    this.reconciliationReferenceId,
    this.reference2,
  });

  CompleteRowData.fromJson(Map<String, dynamic> json) {
    recordId = json['RecordId'];
    data = json['Data'];
    reference = json['Reference'];
    amount = json['Amount'];
    date = json['Date'];
    status = json['Status'];
    subStatus = json['SubStatus'];
    description = json['Description'];
    confirmed = json['Confirmed'];
    matchReferenceNumber = json['MatchReferenceNumber'];
    updateStatus = json['UpdateStatus'];
    updatedBy = json['UpdatedBy'];
    amountUpdated = json['AmountUpdated'];
    referenceUpdated = json['ReferenceUpdated'];
    dateUpdated = json['DateUpdated'];
    sequence = json['sequence'];
    reconciliationReferenceId = json['ReconciliationReferenceId'];
    reference2 = json['Reference_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RecordId'] = recordId;
    data['Data'] = this.data;
    data['Reference'] = reference;
    data['Amount'] = amount;
    data['Date'] = date;
    data['Status'] = status;
    data['SubStatus'] = subStatus;
    data['Description'] = description;
    data['Confirmed'] = confirmed;
    data['MatchReferenceNumber'] = matchReferenceNumber;
    data['UpdateStatus'] = updateStatus;
    data['UpdatedBy'] = updatedBy;
    data['AmountUpdated'] = amountUpdated;
    data['ReferenceUpdated'] = referenceUpdated;
    data['DateUpdated'] = dateUpdated;
    data['sequence'] = sequence;
    data['ReconciliationReferenceId'] = reconciliationReferenceId;
    data['Reference_2'] = reference2;
    return data;
  }
}
