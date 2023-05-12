import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/data/repositories/reprocess/reprocess.dart';

part 'reprocess_state.dart';

class ReprocessCubit extends Cubit<ReprocessState> {
  ReprocessCubit() : super(ReprocessInitial());
  reprocess({
    required int reconciliationReferenceId,
  }) async {
    emit(ReprocessingState());
    try {
      final response = await ReprocessRepository().reprocess(
        reconciliationReferenceId: reconciliationReferenceId,
      );
      log('Reprocess response: ${response.data.toString()}');
      emit(ReprocessingDoneState());
    } on DioError catch (e) {
      log('Reprocessing failed: ${e.toString()}');
      emit(ReprocessingFailedState());
    } catch (e) {
      emit(ReprocessingFailedState());
    }
  }
}
