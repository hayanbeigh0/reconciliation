import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/models/table_row_data.dart';
import 'package:reconciliation/data/repositories/data_enquiry/data_enquiry.dart';

part 'data_enquiry_state.dart';

class SheetOneDataEnquiryCubit extends Cubit<SheetOneDataEnquiryState> {
  final DataEnquiryRepository dataEnquiryRepository;
  SheetOneDataEnquiryCubit(this.dataEnquiryRepository)
      : super(SheetOneDataEnquiryInitial());
  List<TableRowData> tableRowData = [];
  List<TableRowData> filteredTableRowData = [];
  clearTableRowData() {
    tableRowData = [];
    filteredTableRowData = [];
    log('Table data cleared');
  }

  getSheetOneData({
    required int reconciliationReferenceId,
    required int pageNumber,
  }) async {
    if (pageNumber == 1) {
      tableRowData = [];
      filteredTableRowData = [];
      emit(SheetOneInitialEnquiryStartedState());
    }
    try {
      final response = await dataEnquiryRepository.getSheetOneData(
        reconciliationReferenceId: reconciliationReferenceId,
        pageNumber: pageNumber,
      );
      print('Sheet 1 response:${response.data}');
      tableRowData = tableRowData +
          (response.data['Rows'] as List<dynamic>)
              .map((e) => TableRowData.fromJson(e))
              .toList();
      emit(
        SheetOneEnquiryDonetate(
          tableRowData: tableRowData,
          currentPage: response.data['CurrentPage'],
        ),
      );
    } on DioError catch (e) {
      log(e.response.toString());
      emit(SheetOneEnquiryFailedState());
    }
  }

  getSheetOneDataWithoutLoading({
    required int reconciliationReferenceId,
    required int pageNumber,
  }) async {
    if (pageNumber == 1) {
      tableRowData = [];
    }
    try {
      final response = await dataEnquiryRepository.getSheetOneData(
        reconciliationReferenceId: reconciliationReferenceId,
        pageNumber: pageNumber,
      );
      // print('Sheet 1 response:${response.data}');
      tableRowData = tableRowData +
          (response.data['Rows'] as List<dynamic>)
              .map((e) => TableRowData.fromJson(e))
              .toList();
      log('Sheet one length: ${tableRowData.length}');
      emit(
        SheetOneEnquiryDonetate(
          tableRowData: tableRowData,
          currentPage: response.data['CurrentPage'],
        ),
      );
    } on DioError catch (e) {
      log(e.response.toString());
      emit(SheetOneEnquiryFailedState());
    }
  }

  loadSheetOneFilteredData({
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
      emit(SheetOneInitialEnquiryStartedState());
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
    // print('Filtered sheet 1 data:${response.data.toString()}');
    filteredTableRowData = filteredTableRowData +
        response.data['Rows']
            .map((e) => TableRowData.fromJson(e))
            .toList()
            .cast<TableRowData>();
    // log('Filtered sheet length: ${filteredTableRowData.length.toString()}');
    emit(SheetOneEnquiryDonetate(
      tableRowData: filteredTableRowData,
      currentPage: response.data['CurrentPage'],
    ));
  }
}
