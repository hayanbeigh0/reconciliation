class JobList {
  String? reconciliationReference;
  int? reconciliationReferenceId;
  String? createdDateTime;
  String? lastModified;
  String? sheetOnePath;
  String? sheetTwoPath;
  String? sheetOneResultPath;
  String? sheetTwoResultPath;
  String? reconciliationStatus;
  String? sheetOneMapping;
  String? sheetTwoMapping;
  int? matchingProcessPercentage;
  int? active;

  JobList({
    this.reconciliationReference,
    this.reconciliationReferenceId,
    this.createdDateTime,
    this.lastModified,
    this.sheetOnePath,
    this.sheetTwoPath,
    this.sheetOneResultPath,
    this.sheetTwoResultPath,
    this.reconciliationStatus,
    this.sheetOneMapping,
    this.sheetTwoMapping,
    this.matchingProcessPercentage,
    this.active,
  });

  JobList.fromJson(Map<String, dynamic> json) {
    reconciliationReference = json['ReconciliationReference'];
    reconciliationReferenceId = json['ReconciliationReferenceId'];
    createdDateTime = json['CreatedDateTime'];
    lastModified = json['LastModified'];
    sheetOnePath = json['SheetOnePath'];
    sheetTwoPath = json['SheetTwoPath'];
    sheetOneResultPath = json['SheetOneResultPath'];
    sheetTwoResultPath = json['SheetTwoResultPath'];
    reconciliationStatus = json['ReconciliationStatus'];
    sheetOneMapping = json['SheetOneMapping'];
    sheetTwoMapping = json['SheetTwoMapping'];
    matchingProcessPercentage = json['MatchingProcessPercentage'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReconciliationReference'] = reconciliationReference;
    data['ReconciliationReferenceId'] = reconciliationReferenceId;
    data['CreatedDateTime'] = createdDateTime;
    data['LastModified'] = lastModified;
    data['SheetOnePath'] = sheetOnePath;
    data['SheetTwoPath'] = sheetTwoPath;
    data['SheetOneResultPath'] = sheetOneResultPath;
    data['SheetTwoResultPath'] = sheetTwoResultPath;
    data['ReconciliationStatus'] = reconciliationStatus;
    data['SheetOneMapping'] = sheetOneMapping;
    data['SheetTwoMapping'] = sheetTwoMapping;
    data['MatchingProcessPercentage'] = matchingProcessPercentage;
    data['Active'] = active;
    return data;
  }
}
