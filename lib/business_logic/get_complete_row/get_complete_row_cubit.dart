import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/models/complete_row_data.dart';
import 'package:reconciliation/data/repositories/data_enquiry/data_enquiry.dart';

part 'get_complete_row_state.dart';

class GetCompleteRowCubit extends Cubit<GetCompleteRowState> {
  GetCompleteRowCubit(this.dataEnquiryRepository)
      : super(GetCompleteRowInitial());
  final DataEnquiryRepository dataEnquiryRepository;
  getCompleteRowData({
    required int recordId,
    required int sheetNumber,
  }) async {
    emit(LoadingCompleteRowState());
    try {
      final response = await dataEnquiryRepository.getCompleteRowData(
        recordId: recordId,
        sheetNumber: sheetNumber,
      );
      if (response.data.isNotEmpty) {
        CompleteRowData completeRowData = CompleteRowData.fromJson(
          response.data[0],
        );
        emit(LoadingCompleteRowSuccessState(completeRowData: completeRowData));
      } else {
        emit(LoadingCompleteRowFailedState());
      }
    } on DioError catch (e) {
      emit(LoadingCompleteRowFailedState());
      log(e.response.toString());
    }
  }
}
