import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/repositories/get_job/get_job.dart';

part 'get_job_details_state.dart';

class GetJobDetailsCubit extends Cubit<GetJobDetailsState> {
  GetJobDetailsCubit() : super(GetJobDetailsInitial());
  final GetJobRepository getJobRepository = GetJobRepository();
  static List<String> requestedForDownloadJobs = [];

  Future<void> getJobDetailsById(String reconciliationReferenceId) async {
    // requestedForDownloadJobs.add(reconciliationReferenceId);
    // requestedForDownloadJobs = requestedForDownloadJobs.toSet().toList();
    log('Download queue length: ${requestedForDownloadJobs.length}');
    try {
      emit(GettingJobDetailsByIdState(
        reconciliationReferenceId: reconciliationReferenceId,
      ));

      // for (final referenceId in requestedForDownloadJobs) {
      await Future.delayed(const Duration(seconds: 3));
      final response =
          await getJobRepository.getJobDetailsById(reconciliationReferenceId);
      print('Job detail response: ${response.data.toString()}');

      if (response.data[0]['SheetOneResultPath'] == null ||
          response.data[0]['SheetOneResultPath'].isEmpty ||
          response.data[0]['SheetTwoResultPath'] == null ||
          response.data[0]['SheetTwoResultPath'].isEmpty) {
        log('Empty result paths!');
        emit(ResultPathsEmptyState(
          reconciliationReferenceId: reconciliationReferenceId,
        ));
      } else {
        log('Result paths are available!');
        // requestedForDownloadJobs
        //     .removeWhere((id) => id == reconciliationReferenceId);

        emit(ResultPathsNotEmptyState(
          reconciliationReferenceId: reconciliationReferenceId,
        ));
      }
      // }
    } on DioError catch (e) {
      emit(GettingJobDetailsByIdFailedState());
      log('Getting job details by Id error: ${e.toString()}');
    } catch (e) {
      log('Error while getting job details from JobDetailsCubit');
    }
  }
}
