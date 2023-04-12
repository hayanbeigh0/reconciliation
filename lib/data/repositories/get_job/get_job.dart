import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class GetJobRepository {
  Future<Response> getJobList() async {
    log('getting jobs from the repository');
    final response = await Dio().get(
      'http://15.206.76.18:8080/api/v1/job/getAllActiveJobs',
    );
    return response;
  }

  Future<Response> downloadFile(String referenceId) async {
    log('Downloading file: ${int.parse(referenceId)}');
    final response = await Dio().post(
      'http://15.206.76.18:8080/api/v1/job/excelDownload',
      data: {"ReconciliationReferenceId": int.parse(referenceId)},
    );
    return response;
  }
}
