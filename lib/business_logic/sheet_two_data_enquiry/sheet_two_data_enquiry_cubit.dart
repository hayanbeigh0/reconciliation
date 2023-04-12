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
      List<TableRowData> tableRowData = (response.data as List<dynamic>)
          .map((e) => TableRowData.fromJson(e))
          .toList();
      emit(SheetTwoEnquiryDoneState(tableRowData: tableRowData));
    } on DioError catch (e) {
      emit(SheetTwoEnquiryFailedState());
      log(e.response.toString());
    }
  }

  eraseSheetTwoData() {
    emit(const SheetTwoEnquiryDoneState(tableRowData: []));
  }
}
