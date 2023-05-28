import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reconciliation/constants/env_variable.dart';

class DataEnquiryRepository {
  Future<Response> getSheetOneData({
    required int reconciliationReferenceId,
    required int pageNumber,
  }) async {
    final response = await Dio().post(
      '$API_URL/enquiry/getSheetOneData',
      data: {
        "ReconciliationReferenceId": reconciliationReferenceId,
        "PageNumber": pageNumber
      },
    );
    return response;
  }

  Future<Response> getSheetTwoData({
    required int reconciliationReferenceId,
    required String matchReferenceNumber,
  }) async {
    final response = await Dio().post(
      '$API_URL/enquiry/getMatchedData',
      data: {
        "ReconciliationReferenceId": reconciliationReferenceId,
        "MatchReferenceNumber": matchReferenceNumber
      },
    );
    return response;
  }

  Future<Response> getCompleteRowData({
    required int recordId,
    required int sheetNumber,
  }) async {
    final response = await Dio().post(
      '$API_URL/enquiry/getCompleteRow',
      data: {"RecordId": recordId, "SheetNumber": sheetNumber},
    );
    return response;
  }

  Future<Response> updateRowData({
    required String recordId,
    required String reconciliationReferenceId,
    required String sheetNumber,
    required String userId,
    required List<Map<String, dynamic>> updates,
  }) async {
    log('Updating from the repository');
    log({
      "RecordId": recordId,
      "ReconciliationReferenceId": reconciliationReferenceId,
      "SheetNumber": int.parse(sheetNumber),
      "UserId": userId,
      "Updates": updates
    }.toString());
    final response = await Dio().put(
      '$API_URL/enquiry/updateRow',
      data: {
        "RecordId": recordId,
        "ReconciliationReferenceId": reconciliationReferenceId,
        "SheetNumber": int.parse(sheetNumber),
        "UserId": userId,
        "Updates": updates
      },
    );
    return response;
  }

  Future<Response> getSheetFilteredData({
    required String? reference,
    required num? amountFrom,
    required num? amountTo,
    required String? status,
    required String? subStatus,
    required int? confirmation,
    required int? reconciliationReferenceId,
    required int? sheetNumber,
    required int? pageNumber,
  }) async {
    // log('Reference: ${reference.toString()}');
    // log('Amount From: ${amountFrom.toString()}');
    // log('Amount To: ${amountTo.toString()}');
    // log('Status: ${status.toString()}');
    // log('Sub Status: ${subStatus.toString()}');
    // log('Confirmation: ${confirmation.toString()}');
    // log('Reconciliation Reference Id: ${reconciliationReferenceId.toString()}');
    final response = await Dio().post(
      '$API_URL/enquiry/getFilteredRows',
      data: {
        "ReconciliationReferenceId": reconciliationReferenceId,
        "Reference": reference,
        "AmountFrom": amountFrom,
        "AmountTo": amountTo,
        "Status": status,
        "SubStatus": subStatus,
        "Confirmed": confirmation,
        "SheetNumber": sheetNumber,
        "PageNumber": pageNumber
      },
    );
    log('Filtered rows response from repository: ${response.data.toString()}');
    return response;
  }
}
// {
//   "ReconciliationReferenceId" : 226,
//   "SheetNumber" : 2,
//   "Reference" : null,
//   "AmountFrom" : 500,
//   "AmountTo" : 5000,
//   "Status" : null,
//   "SubStatus" : null,
//   "Confirmed" : 1,
//   "PageNumber" : 1
// }