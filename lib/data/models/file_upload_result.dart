class FileUploadResult {
  Sheet1? sheet1;
  Sheet1? sheet2;

  FileUploadResult({this.sheet1, this.sheet2});

  FileUploadResult.fromJson(Map<String, dynamic> json) {
    sheet1 = json['sheet1'] != null ? Sheet1.fromJson(json['sheet1']) : null;
    sheet2 = json['sheet2'] != null ? Sheet1.fromJson(json['sheet2']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sheet1 != null) {
      data['sheet1'] = sheet1!.toJson();
    }
    if (sheet2 != null) {
      data['sheet2'] = sheet2!.toJson();
    }
    return data;
  }
}

class Sheet1 {
  String? eTag;
  String? serverSideEncryption;
  String? location;
  String? key1;
  String? key2;
  String? bucket;

  Sheet1(
      {this.eTag,
      this.serverSideEncryption,
      this.location,
      this.key1,
      this.key2,
      this.bucket});

  Sheet1.fromJson(Map<String, dynamic> json) {
    eTag = json['ETag'];
    serverSideEncryption = json['ServerSideEncryption'];
    location = json['Location'];
    key1 = json['key'];
    key2 = json['Key'];
    bucket = json['Bucket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ETag'] = eTag;
    data['ServerSideEncryption'] = serverSideEncryption;
    data['Location'] = location;
    data['key'] = key1;
    data['Key'] = key2;
    data['Bucket'] = bucket;
    return data;
  }
}
