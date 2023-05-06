import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reconciliation/constants/env_variable.dart';

class GetJobRepository {
  Future<Response> getJobList() async {
    log('getting jobs from the repository');
    final response = await Dio().get(
      '$API_URL/job/getAllActiveJobs',
    );
    print(response.data.toString());
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
}
