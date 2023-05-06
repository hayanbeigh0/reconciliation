import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/data/repositories/add_job/add_job_repository.dart';

part 'upload_file_1_state.dart';

class UploadFile1Cubit extends Cubit<UploadFile1State> {
  UploadFile1Cubit() : super(UploadFile1Initial());
  AddJobRepository addJobRepository = AddJobRepository();
  Future<void> uploadFile1({
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    try {
      emit(UploadFile1Started());
      final response = await addJobRepository.uploadFile(
        fileBytes: fileBytes,
        fileName: fileName,
      );
      log(response.data['columns'].toString());
      emit(
        UploadFile1Done(
            file1Columns: response.data['columns']
                .map((e) => e.toString())
                .toSet()
                .toList()
                .cast<String>()),
      );
    } on DioError catch (e) {
      log(e.message.toString());
      emit(UploadFile1Failed());
    } catch (e) {
      log('Error while uploading excel file from UploadFile1Cubit');
      emit(UploadFile1Failed());
    }
  }

  removeFile1() {
    emit(File1Removed());
  }
}
