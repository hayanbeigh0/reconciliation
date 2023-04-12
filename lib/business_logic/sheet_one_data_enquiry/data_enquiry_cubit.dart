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
  getSheetOneData({
    required int reconciliationReferenceId,
  }) async {
    emit(SheetOneEnquiryStartedState());
    try {
      final response = await dataEnquiryRepository.getSheetOneData(
        reconciliationReferenceId: reconciliationReferenceId,
      );
      List<TableRowData> tableRowData = (response.data as List<dynamic>)
          .map((e) => TableRowData.fromJson(e))
          .toList();
      emit(SheetOneEnquiryDonetate(tableRowData: tableRowData));
    } on DioError catch (e) {
      emit(SheetOneEnquiryFailedState());
      log(e.response.toString());
    }
  }
}
