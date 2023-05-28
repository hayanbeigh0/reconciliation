import 'dart:convert';
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

  Future<Response> requestDownload(
      {required int reconciliationReferenceId}) async {
    final response = await Dio().post(
      '$API_URL/enquiry/requestDownload',
      data: jsonEncode(
        {
          "ReconciliationReferenceId": reconciliationReferenceId,
        },
      ),
    );
    return response;
  }

  Future<Response> getResultFilesURL({
    required int reconciliationReferenceId,
    required int downloadId,
  }) async {
    final Response response = await Dio().post(
      '$API_URL/enquiry/getResultFilesURL',
      data: jsonEncode(
        {
          "ReconciliationReferenceId": reconciliationReferenceId,
          "DownloadId": downloadId
        },
      ),
    );
    log('Result file url\'s from the repository: ${response.data}');
    return response;
  }
}
