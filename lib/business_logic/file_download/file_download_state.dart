part of 'file_download_cubit.dart';

abstract class FileDownloadState extends Equatable {
  const FileDownloadState();
}

class FileDownloadInitial extends FileDownloadState {
  @override
  List<Object> get props => [];
}

class FileDownloadingState extends FileDownloadState {
  @override
  List<Object> get props => [];
}

class FileDownloadingFailedState extends FileDownloadState {
  @override
  List<Object> get props => [];
}

class FileDownloadedState extends FileDownloadState {
  @override
  List<Object> get props => [];
}

class GettingResultFilesUrlFailedState extends FileDownloadState {
  @override
  List<Object?> get props => [];
}
