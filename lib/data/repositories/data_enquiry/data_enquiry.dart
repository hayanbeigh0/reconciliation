import 'package:dio/dio.dart';

class DataEnquiryRepository {
  Future<Response> getSheetOneData({
    required int reconciliationReferenceId,
  }) async {
    final response = await Dio().post(
      'http://15.206.76.18:8080/api/v1/enquiry/getSheetOneData',
      data: {"ReconciliationReferenceId": reconciliationReferenceId},
    );
    return response;
  }

  Future<Response> getSheetTwoData({
    required int reconciliationReferenceId,
    required String matchReferenceNumber,
  }) async {
    final response = await Dio().post(
      'http://15.206.76.18:8080/api/v1/enquiry/getMatchedData',
      data: {
        "ReconciliationReferenceId": reconciliationReferenceId,
        "MatchReferenceNumber": matchReferenceNumber
      },
    );
    return response;
  }
}
