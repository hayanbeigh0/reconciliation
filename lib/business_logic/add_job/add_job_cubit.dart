import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/models/file_upload_result.dart';
import 'package:reconciliation/data/repositories/add_job/add_job_repository.dart';

part 'add_job_state.dart';

class AddJobCubit extends Cubit<AddJobState> {
  final AddJobRepository addJobRepository;
  AddJobCubit(this.addJobRepository) : super(AddJobInitial());
  uploadFile({
    required String referenceName,
    required Uint8List file1Bytes,
    required Uint8List file2Bytes,
    required String file1Name,
    required String file2Name,
    required List<String> columns1,
    required List<String> columns2,
    required Map<String, dynamic> sheet1Mapping,
    required Map<String, dynamic> sheet2Mapping,
  }) async {
    emit(AddingJobState());
    try {
      final response = await addJobRepository.uploadExcel(
        file1Bytes: file1Bytes,
        file2Bytes: file2Bytes,
        file1Name: file1Name,
        file2Name: file2Name,
        columns1: columns1,
        columns2: columns2,
      );
      FileUploadResult fileUploadResult =
          FileUploadResult.fromJson(response.data);
      // emit(FileUploadSuccessState(fileUploadResult: fileUploadResult));
      final addJobResponse = await addJob(
        referenceName: referenceName,
        sheet1Path: fileUploadResult.sheet1!.key1!,
        sheet2Path: fileUploadResult.sheet2!.key1!,
        sheet1Mapping: sheet1Mapping,
        sheet2Mapping: sheet2Mapping,
      );
      if (addJobResponse.data[0]['ReconciliationReference'] != null) {
        emit(AddingJobSuccessState());
      }
    } on DioError catch (e) {
      log('Error while uploading the files: ${e.response!.data.toString()}');
      emit(AddingJobFailedState());
    }
  }

  Future<Response> addJob({
    required String referenceName,
    required String sheet1Path,
    required String sheet2Path,
    required Map<String, dynamic> sheet1Mapping,
    required Map<String, dynamic> sheet2Mapping,
  }) async {
    // try {
    final response = await addJobRepository.addjob(
      referenceName: referenceName,
      sheet1Path: sheet1Path,
      sheet2Path: sheet2Path,
      sheet1Mapping: sheet1Mapping,
      sheet2Mapping: sheet2Mapping,
    );
    log('Adding job success: ${response.data.toString()}');
    return response;
  }

  checkReferenceAvailability(String referenceName) async {
    if (referenceName.isEmpty) {
      emit(ReferenceNotFetchingState());
    }
    try {
      emit(CheckingReferenceAvailabilityState());
      final response =
          await addJobRepository.checkReferenceAvailability(referenceName);
      log(response.data.toString());
      if (!response.data['referenceExist']) {
        emit(CheckingReferenceAvailabilitySuccessState());
      } else {
        emit(CheckingReferenceAvailabilityFailedState());
      }
    } on DioError catch (e) {
      log(e.response!.data.toString());
      emit(CheckingReferenceAvailabilityFailedState());
    } catch (e) {
      log(e.toString());
      emit(CheckingReferenceAvailabilityFailedState());
    }
  }

  noReferenceRequired() {
    emit(ReferenceNotFetchingState());
  }

  addingFile() {
    emit(AddingFileState());
  }

  addedFileState() {
    emit(AddedFileState());
  }
}
