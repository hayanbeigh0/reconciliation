import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/models/file_download.dart';
import 'package:reconciliation/data/repositories/file_download/file_download.dart';

part 'get_downloadable_files_state.dart';

class DownloadableFilesCubit extends Cubit<DownloadableFilesState> {
  DownloadableFilesCubit() : super(DownloadableFilesInitial());

  getDownloadableFilesList() async {
    emit(LoadingDownloadableFilesState());
    try {
      final response =
          await FileDownloadRepository().getDownloadableFilesList();

      final downloadableFilesList = List<FileDownload>.from(
        response.data.map(
          (e) => FileDownload.fromJson(e),
        ),
      );
      log(response.data.toString());
      emit(DownloadableFilesLoadedState(
        downloadableFiles: downloadableFilesList,
      ));
    } on DioError catch (e) {
      emit(LoadingDownloadableFilesFailedState());
      log(e.message.toString());
    } catch (e) {
      emit(LoadingDownloadableFilesFailedState());
      log(e.toString());
    }
  }
}
