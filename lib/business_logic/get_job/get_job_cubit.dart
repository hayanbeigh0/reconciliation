import 'dart:developer';
import 'dart:html' as html;
import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reconciliation/data/models/job_list.dart';
import 'package:reconciliation/data/repositories/get_job/get_job.dart';

part 'get_job_state.dart';

class GetJobCubit extends Cubit<GetJobState> {
  List<JobList> allJobs = [];
  GetJobCubit(this.getJobRepository) : super(GetJobInitial());
  final GetJobRepository getJobRepository;
  List<JobList> jobList = [];
  Future<void> getJobList() async {
    emit(GettingJobListState());
    try {
      final response = await getJobRepository.getJobList();
      jobList = (response.data as List<dynamic>)
          .map((e) => JobList.fromJson(e))
          .toList();

      if (jobList.isEmpty) {
        emit(JobListEmptyState());
      } else {
        jobList.sort(
          (a, b) => b.createdDateTime!.compareTo(a.createdDateTime!),
        );
        allJobs = jobList;
        emit(GettingJobListDoneState(jobList: jobList));
      }
    } on DioError catch (e) {
      log('Getting job failed: ${e.message}');
      emit(GettingJobListFailedState());
    }
  }

  Future<void> downloadFile({
    required String referenceId,
  }) async {
    // emit(JobDownloadingState(jobList: allJobs));
    try {
      final response = await getJobRepository.downloadFile(referenceId);
      downloadFileFromUrl(response.data[0], response.data[1]);
      // emit(JobDownloadedState());
      // emit(GettingJobListDoneState(jobList: allJobs));
    } on DioError catch (e) {
      log('Downloading job failed: ${e.message}');
      emit(JobDownloadingFailedState());
    }
  }

  void getFilteredJobList({
    required DateTime? dateFrom,
    required DateTime? dateTo,
    required String? status,
    required String? reference,
  }) {
    emit(GettingJobListState());
    List<JobList> filteredJobList = jobList.where((element) {
      if ((dateFrom == null ||
              DateTime.parse(element.createdDateTime.toString())
                  .isAfter(DateTime.parse(dateFrom.toString()))) &&
          (dateTo == null ||
              DateTime.parse(element.createdDateTime.toString())
                  .isBefore(DateTime.parse(dateTo.toString()))) &&
          (status == null ||
              status.isEmpty ||
              status.toLowerCase() ==
                  element.reconciliationStatus!.toLowerCase()) &&
          (reference == null ||
              reference.isEmpty ||
              reference.replaceAll(' ', '').toLowerCase() ==
                  element.reconciliationReference!
                      .replaceAll(' ', '')
                      .toLowerCase())) {
        return true;
      } else {
        return false;
      }
    }).toList();
    log(filteredJobList.length.toString());
    emit(GettingJobListDoneState(jobList: filteredJobList));
  }

  void downloadFileFromUrl(String url1, String url2) async {
    html.AnchorElement anchorElement1 = html.AnchorElement(href: url1);
    anchorElement1.download = url1;
    html.AnchorElement anchorElement2 = html.AnchorElement(href: url2);
    anchorElement2.download = url2;
    anchorElement1.click();
    await Future.delayed(const Duration(seconds: 2));
    anchorElement2.click();
  }
}
