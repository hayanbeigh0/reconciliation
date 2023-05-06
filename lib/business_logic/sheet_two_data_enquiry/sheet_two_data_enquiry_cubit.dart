import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/data/models/table_row_data.dart';
import 'package:reconciliation/data/repositories/data_enquiry/data_enquiry.dart';

part 'sheet_two_data_enquiry_state.dart';

class SheetTwoDataEnquiryCubit extends Cubit<SheetTwoDataEnquiryState> {
  final DataEnquiryRepository dataEnquiryRepository;
  SheetTwoDataEnquiryCubit(this.dataEnquiryRepository)
      : super(SheetTwoDataEnquiryInitial());
  List<TableRowData> tableRowData = [];
  List<TableRowData> filteredTableRowData = [];
  getSheetTwoData({
    required int reconciliationReferenceId,
    required String matchReferenceNumber,
  }) async {
    emit(SheetTwoEnquiryStartedState());
    try {
      final response = await dataEnquiryRepository.getSheetTwoData(
        reconciliationReferenceId: reconciliationReferenceId,
        matchReferenceNumber: matchReferenceNumber,
      );
      // print('Sheet 2 response:${response.data}');
      tableRowData = (response.data as List<dynamic>)
          .map((e) => TableRowData.fromJson(e))
          .toList();
      emit(
        SheetTwoEnquiryDoneState(
          tableRowData: tableRowData,
          currentPage: 2,
        ),
      );
    } on DioError catch (e) {
      emit(SheetTwoEnquiryFailedState());
      log(e.response.toString());
    }
  }

  eraseSheetTwoData() {
    emit(
      const SheetTwoEnquiryDoneState(
        tableRowData: [],
        currentPage: 1,
      ),
    );
  }

  loadSheetTwoFilteredData({
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
    if (pageNumber == 1) {
      filteredTableRowData = [];
      emit(SheetTwoEnquiryStartedState());
    }
    final response = await dataEnquiryRepository.getSheetFilteredData(
      amountFrom: amountFrom,
      amountTo: amountTo,
      status: status,
      confirmation: confirmation,
      reference: reference,
      reconciliationReferenceId: reconciliationReferenceId,
      subStatus: subStatus,
      sheetNumber: sheetNumber,
      pageNumber: pageNumber,
    );
    // print('Filtered sheet 2 data:${response.data.toString()}');
    filteredTableRowData = filteredTableRowData +
        response.data['Rows']
            .map((e) => TableRowData.fromJson(e))
            .toList()
            .cast<TableRowData>();
    // log(filteredTableRowData.length.toString());
    emit(
      SheetTwoEnquiryDoneState(
        tableRowData: filteredTableRowData,
        currentPage: int.parse(response.data['CurrentPage'].toString()),
      ),
    );
  }
}
