import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reconciliation/data/repositories/get_job/get_job.dart';

part 'get_job_details_state.dart';

class GetJobDetailsCubit extends Cubit<GetJobDetailsState> {
  GetJobDetailsCubit() : super(GetJobDetailsInitial());
  final GetJobRepository getJobRepository = GetJobRepository();
  static List<String> requestedForDownloadJobs = [];

  Future<void> requestDownload({
    required int reconciliationReferenceId,
    required BuildContext context,
  }) async {
    emit(GettingJobDetailsByIdState(
      reconciliationReferenceId: reconciliationReferenceId.toString(),
    ));
    try {
      await getJobRepository
          .requestDownload(
        reconciliationReferenceId: reconciliationReferenceId,
      )
          .then((value) {
        log('Download requested successfully: ${value.data.toString()}');
        // BlocProvider.of<GetJobDetailsCubit>(context).getJobDetailsById(
        //   reconciliationReferenceId.toString(),
        // );
        return value;
      });
    } on DioError catch (e) {
      log('Download request failed: ${e.message}');
      emit(DownloadRequestFailedState());
    } catch (e) {
      log('Download request failed: $e');
      emit(DownloadRequestFailedState());
    }
  }

  // Future<void> getResultFilesUrl({
  //   required int reconciliationReferenceId,
  // }) async {
  //   try {
  //     final response = await getJobRepository.getResultFilesURL(
  //         reconciliationReferenceId: reconciliationReferenceId, downloadId: 1);
  //     // print('Result files URl\'s: ${response.data}');
  //     // To download files after getting the URL's from the response
  //     downloadFileFromUrl(response.data[0], response.data[1]);
  //   } on DioError catch (e) {
  //     log('Getting result files URL\'s failed: ${e.message}');
  //     emit(GettingResultFilesUrlFailedState());
  //   } catch (e) {
  //     log('Getting result files URL\'s failed: $e');
  //     emit(GettingResultFilesUrlFailedState());
  //   }
  // }

  // void downloadFileFromUrl(String url1, String url2) async {
  //   html.AnchorElement anchorElement1 = html.AnchorElement(href: url1);
  //   anchorElement1.download = url1;
  //   html.AnchorElement anchorElement2 = html.AnchorElement(href: url2);
  //   anchorElement2.download = url2;
  //   anchorElement1.click();
  //   await Future.delayed(const Duration(seconds: 2));
  //   anchorElement2.click();
  // }

  // Future<void> getJobDetailsById(String reconciliationReferenceId) async {
  //   // requestedForDownloadJobs.add(reconciliationReferenceId);
  //   // requestedForDownloadJobs = requestedForDownloadJobs.toSet().toList();
  //   // log('Download queue length: ${requestedForDownloadJobs.length}');
  //   try {
  //     emit(GettingJobDetailsByIdState(
  //       reconciliationReferenceId: reconciliationReferenceId,
  //     ));
  //     // for (final referenceId in requestedForDownloadJobs) {
  //     await Future.delayed(const Duration(seconds: 3));
  //     final response =
  //         await getJobRepository.getJobDetailsById(reconciliationReferenceId);
  //     // print('Job detail response: ${response.data.toString()}');

  //     if (response.data[0]['SheetOneResultPath'] == null ||
  //         response.data[0]['SheetOneResultPath'].isEmpty ||
  //         response.data[0]['SheetTwoResultPath'] == null ||
  //         response.data[0]['SheetTwoResultPath'].isEmpty) {
  //       log('Empty result paths!');
  //       emit(ResultPathsEmptyState(
  //         reconciliationReferenceId: reconciliationReferenceId,
  //       ));
  //     } else {
  //       log('Result paths are available!');
  //       // requestedForDownloadJobs
  //       //     .removeWhere((id) => id == reconciliationReferenceId);

  //       emit(ResultPathsNotEmptyState(
  //         reconciliationReferenceId: reconciliationReferenceId,
  //       ));
  //     }
  //     // }
  //   } on DioError catch (e) {
  //     emit(GettingJobDetailsByIdFailedState());
  //     log('Getting job details by Id error: ${e.toString()}');
  //   } catch (e) {
  //     log('Error while getting job details from JobDetailsCubit');
  //   }
  // }
}
