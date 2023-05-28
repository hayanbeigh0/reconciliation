import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/repositories/file_download/file_download.dart';

part 'delete_downloadable_files_state.dart';

class DeleteDownloadableFilesCubit extends Cubit<DeleteDownloadableFilesState> {
  DeleteDownloadableFilesCubit() : super(DeleteDownloadableFilesInitial());
  deleteDownloadableFile({
    required int downloadId,
    required int reconciliationReferenceId,
  }) async {
    try {
      final response = await FileDownloadRepository().deleteDownloadableFile(
        downloadId: downloadId,
        reconciliationReferenceId: reconciliationReferenceId,
      );
      log(response.data.toString());
      emit(DeletedDownloadableFileState());
    } on DioError catch (e) {
      log(e.message.toString());
      emit(DeletingDownloadableFileFailedState());
    } catch (e) {
      log(e.toString());
      emit(DeletingDownloadableFileFailedState());
    }
  }
}
