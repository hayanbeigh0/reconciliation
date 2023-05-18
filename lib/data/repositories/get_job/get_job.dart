import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reconciliation/constants/env_variable.dart';

class GetJobRepository {
  Future<Response> getJobList() async {
    final response = await Dio().get(
      '$API_URL/job/getAllActiveJobs',
    );
    // print('Job List from repository: ${response.data.toString()}');
    return response;
  }

  Future<Response> downloadFile(String referenceId) async {
    log('Downloading file: ${int.parse(referenceId)}');
    final response = await Dio().post(
      '$API_URL/job/excelDownload',
      data: {"ReconciliationReferenceId": int.parse(referenceId)},
    );
    return response;
  }

  Future<Response> getJobDetailsById(String reconciliationReferenceId) async {
    final response = await Dio().get(
      '$API_URL/job/jobDetailsById/$reconciliationReferenceId',
    );
    return response;
  }
}
