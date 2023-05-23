import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reconciliation/data/repositories/get_job/get_job.dart';

part 'file_download_state.dart';

class FileDownloadCubit extends Cubit<FileDownloadState> {
  FileDownloadCubit() : super(FileDownloadInitial());
  Future<void> getResultFilesUrl({
    required int reconciliationReferenceId,
    required int downloadId,
  }) async {
    try {
      final response = await GetJobRepository().getResultFilesURL(
        reconciliationReferenceId: reconciliationReferenceId,
        downloadId: downloadId,
      );
      // print('Result files URl\'s: ${response.data}');
      // To download files after getting the URL's from the response
      downloadFileFromUrl(response.data[0], response.data[1]);
    } on DioError catch (e) {
      log('Getting result files URL\'s failed: ${e.message}');
      emit(GettingResultFilesUrlFailedState());
    } catch (e) {
      log('Getting result files URL\'s failed: $e');
      emit(GettingResultFilesUrlFailedState());
    }
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
