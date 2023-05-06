import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/repositories/data_enquiry/data_enquiry.dart';

part 'update_row_data_state.dart';

class UpdateRowDataCubit extends Cubit<UpdateRowDataState> {
  UpdateRowDataCubit(this.dataEnquiryRepository)
      : super(UpdateRowDataInitial());
  final DataEnquiryRepository dataEnquiryRepository;
  updateRowData({
    required String recordId,
    required String reconciliationReferenceId,
    required String sheetNumber,
    required String userId,
    required List<Map<String, dynamic>> updates,
  }) async {
    try {
      emit(UpdatingRowDataStartedState());
      final response = await dataEnquiryRepository.updateRowData(
        recordId: recordId,
        reconciliationReferenceId: reconciliationReferenceId,
        sheetNumber: sheetNumber,
        userId: userId,
        updates: updates,
      );
      log(response.data.toString());
      emit(UpdatingRowDataDoneState());
    } on DioError catch (e) {
      log(e.response.toString());
      emit(UpdatingRowDataFailedState());
    }
  }
}
