// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_downloadable_files_cubit.dart';

abstract class DownloadableFilesState extends Equatable {
  const DownloadableFilesState();
}

class DownloadableFilesInitial extends DownloadableFilesState {
  @override
  List<Object?> get props => [];
}

class LoadingDownloadableFilesState extends DownloadableFilesState {
  @override
  List<Object?> get props => [];
}

class DownloadableFilesLoadedState extends DownloadableFilesState {
  final List<FileDownload> downloadableFiles;
  const DownloadableFilesLoadedState({
    required this.downloadableFiles,
  });
  @override
  List<Object?> get props => [downloadableFiles];
}

class LoadingDownloadableFilesFailedState extends DownloadableFilesState {
  @override
  List<Object?> get props => [];
}
