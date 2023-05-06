import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:reconciliation/data/repositories/add_job/add_job_repository.dart';

part 'upload_file2_state.dart';

class UploadFile2Cubit extends Cubit<UploadFile2State> {
  UploadFile2Cubit() : super(UploadFile2Initial());
  AddJobRepository addJobRepository = AddJobRepository();
  Future<void> uploadFile2({
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    try {
      emit(UploadFile2Started());
      final response = await addJobRepository.uploadFile(
        fileBytes: fileBytes,
        fileName: fileName,
      );
      log(response.data['columns']
          .map((e) => e.toString())
          .toSet()
          .toList()
          .toString());
      emit(
        UploadFile2Done(
            file2Columns: response.data['columns']
                .map((e) => e.toString())
                .toSet()
                .toList()
                .cast<String>()),
      );
    } on DioError catch (e) {
      log(e.message.toString());
      emit(UploadFile2Failed());
    } catch (e) {
      log('Error while uploading excel file from UploadFile1Cubit');
      emit(UploadFile2Failed());
    }
  }
}
