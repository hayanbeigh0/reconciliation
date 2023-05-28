import 'package:dio/dio.dart';
import 'package:reconciliation/constants/env_variable.dart';

class FileDownloadRepository {
  Future<Response> getDownloadableFilesList() async {
    final response = await Dio().get('$API_URL/enquiry/downloads');
    return response;
  }

  Future<Response> deleteDownloadableFile({
    required int downloadId,
    required int reconciliationReferenceId,
  }) async {
    final response = await Dio().delete(
      '$API_URL/enquiry/deleteResultFilesURL',
      data: {
        "ReconciliationReferenceId": reconciliationReferenceId,
        "DownloadId": downloadId
      },
    );
    return response;
  }
}
